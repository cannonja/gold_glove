library(shinythemes)

############################# Set script variables #######################################

required <- c("RODBC", "ggplot2", "fBasics")
from_csv = FALSE
query = "SELECT * FROM FIELDING_CONSOLIDATED WHERE yearID >= 1957"
csv = "FIELDING_CONSOLIDATED.csv"



############################ Define helper functions #####################################

setup_libraries <- function(required) {
  
  installed <- names(installed.packages()[, "Package"])
  
  for (i in required) {
    
    rt <- paste("require(", i, ")", sep="")
    lt <- paste("library(", i, ")", sep="")
    
    if(!eval(parse(text=rt))){
      print(paste("Loading ", i))
      install.packages(i, repos = "http://cran.us.r-project.org")
    }
    
    eval(parse(text = lt))  
    
  }
  
}

plot_histogram <- function(var, df,  bw = 1, x_max = NULL) {
  
  #pop_max <- if (is.null(x_max)) {max(df[toString(var)])} else {x_max}
  pop_max <- if (is.null(x_max)) {max(log10(df[toString(var)] + 1))} else {x_max}

  #ggplot(aes_string(x = toString(var), y = quote(..count../sum(..count..))), data = df) +
  ggplot(aes_string(x = paste("log10(", var, " + 1)", sep = ""), y = quote(..count../sum(..count..))), data = df) +
    geom_histogram(binwidth = bw, color = "black", fill = "#099DD9",
                   boundary = 0) +
    geom_histogram(binwidth = bw, data = subset(df, won_gg == 1, select = var), color = "black",
                   fill = "red", alpha = 0.5, boundary = 0) +
    coord_cartesian(xlim = c(0, pop_max)) +
    scale_x_continuous(breaks = seq(0, pop_max, bw), minor_breaks = NULL, expand = c(0,0.75*bw)) +
    scale_y_continuous(expand = c(0,0)) +
    labs(title = "Population Histogram vs Gold Glove Winners",
         y = "Number of Players as a Proportion of the Population") +
    theme(plot.title = element_text(hjust = 0.5),
          axis.text.x = element_text(angle=90), 
          legend.position = c(.9,.9),
          panel.background = element_rect(fill = NA))
  
}

get_data <- function(query_path, from_csv = FALSE) {
  
  if (!from_csv) {
    
    dbhandle <- if (Sys.info()['nodename'] == "FD63STA001756") {
      
      odbcDriverConnect('driver={SQL Server};server=FD63STA001756\\JAC2;database=lahman;trusted_connection=true')
      
    } else {
      
      odbcDriverConnect('driver={SQL Server};server=DESKTOP-PM6C8DF\\SQLEXPRESS;database=lahman;trusted_connection=true')
      
    }
    
    sqlQuery(dbhandle, query_path)
    
  } else {
    
    suppressWarnings(tryCatch(read.csv(query_path, header = TRUE), 
                              error = function(e) {
                                if (e$message == "cannot open the connection") {
                                  msg <- "Can't find the csv - make sure your working directory is set to the correct location"
                                }
                                else {
                                  msg <- e$message
                                }
                                stop(msg, call. = FALSE)}
                              )
                     )
    
  }
  
}

get_stats <- function(x) {
  stat_names <- c("n", "Mean", "Median", "SD", "IQR", "Skewness", "Kurtosis")
  quantiles <- quantile(x)
  stats <- c(length(x),
             mean(x), 
             quantiles["50%"], 
             sd(x), 
             quantiles["75%"] - quantiles["25%"], 
             skewness(x),
             kurtosis(x)
  )
  
  names(stats) <- stat_names
  stats
  
}












################################ Start App code ##########################################

setup_libraries(required)
data <- if (from_csv) {get_data(csv, from_csv = from_csv)} else {get_data(query)}
data$labels = factor(data$won_gg, levels = c("0", "1"), labels = c("Population", "Gold Glove Winners"))

#dev

# var <- "assists"
# bw <- 0.2
# year = 2000
# data2 <- subset(data, yearID = year)
# pop_max <- max(data2[toString(var)])
# p <- plot_histogram(var, data2, bw)
# p + scale_x_continuous(breaks = seq(0, pop_max, bw), minor_breaks = NULL, expand = c(0,0.75*bw))
# p + scale_x_log10()
# p + scale_x_sqrt()
# 
# p + geom_histogram(binwidth = bw, data = subset(data, yearID = year & won_gg == 1, select = var), color = "black", 
#                fill = "red", alpha = 0.5, boundary = 0)
# 
# 
# 
# stats <- print(p)$data[[1]]
#end dev


server <- function(input, output) {
  
  output$pop_plot <- renderPlot({
    
                        pos <- input$pos
                        var <- switch(pos, C = input$f_statC, P = input$f_statP, input$f_stat)
                        
                        df_in <- if (input$year_range) {
                                  subset(data, yearID >= input$years[1] & yearID <= input$years[2] & (position %in% pos))
                                } else {
                                  subset(data, yearID == input$year & (position %in% pos))
                                }
                        
                        plot_histogram(var, df_in, input$bin_width)
                    
                      })
  
  output$gg_plot <- renderPlot({
    
                      pos <- input$pos
                      
                      df_in <- if (input$year_range) {
                                subset(data, yearID >= input$years[1] & yearID <= input$years[2] & (position %in% pos))
                              } else {
                                subset(data, yearID == input$year & (position %in% pos))
                              }
                      
                      pop_max <- max(subset(df_in, select = input$f_stat))
                      
                      plot_histogram(input$f_stat, df_in[df_in$won_gg == 1,], input$bin_width, pop_max)
                      
                    })  
  
  
  output$summary <- renderTable({

                      pos <- input$pos
                      var <- switch(pos, C = input$f_statC, P = input$f_statP, input$f_stat)

                      df_in <- if (input$year_range) {
                        subset(data, yearID >= input$years[1] & yearID <= input$years[2] & (position %in% pos))
                      } else {
                        subset(data, yearID == input$year & (position %in% pos))
                      }
                      
                      population <- get_stats(subset(df_in, select = input$f_stat)[,1])
                      gg_winners <- get_stats(subset(df_in, won_gg == 1, select = var)[,1])
                      
                      data.frame(Population = population, GGWinners = gg_winners, row.names = names(population))

                    },
                    
                    hover = TRUE,
                    rownames = TRUE
                    )
  
}


positions <- c("1B", "2B", "SS", "3B", "C", "P", "OF", "LF", "RF", "CF")

fielding_stats <- c("num_stints", "games", "games_started", "outs_played", "put_outs",
                    "assists", "errors", "double_plays")

fielding_stats_C <- append(fielding_stats, c("passed_balls", "wild_pitches", "opponent_stolen_bases",
                                             "opponent_caught_stealing", "opponent_steal_attempts", "weighted_zr"))

fielding_stats_P <- append(fielding_stats, c("wins", "losses", "complete_games", "shutouts", "saves", "hits", "earned_runs",
                                             "homeruns", "walks", "strikeouts", "intentional_walks", "batters_hit", "balks",
                                             "batters_faced", "games_finished", "runs_allowed", "batter_sacrifices", "batter_sac_flies",
                                             "grounded_into_dp"))


ui <- fluidPage(
  
  titlePanel("Lahman Fielding EDA"),
  
  fluidRow(
    
    column(2,
    
           selectInput("pos", label = "Select a position", choices = positions, selected = "SS"),
           br(),
           conditionalPanel(condition = "input.pos != 'P' && input.pos != 'C'",
                            selectInput("f_stat", label = "Select fielding stat", choices = fielding_stats, selected = "assists")),
           conditionalPanel(condition = "input.pos == 'C'",
                            selectInput("f_statC", label = "Select fielding stat", choices = fielding_stats_C, selected = "assists")),
           conditionalPanel(condition = "input.pos == 'P'",
                            selectInput("f_statP", label = "Select fielding stat", choices = fielding_stats_P, selected = "assists")),
           
           br(),
           checkboxInput("year_range", label = "Multi Year", value = FALSE),
           #br(),
           conditionalPanel(condition = "input.year_range",
                            sliderInput("years", label = "Select Year Range", min  = min(data$yearID), max = max(data$yearID),
                                        value = c(2000, 2016), step = 1, sep = "")),
           conditionalPanel(condition = "!input.year_range",
                            selectInput("year", label = "Select Year", choices = seq(min(data$yearID), max(data$yearID)),
                                        selected = 2000)),
           br(),
           sliderInput("bin_width", label = "Select Bin Width", min = 1, max = 100, value = c(10), step = 1),
           br(),
           tableOutput("summary")
           
           
           #,shinythemes::themeSelector()
    ),
    
    column(10,
      
          plotOutput("pop_plot")
          #plotOutput("gg_plot")
      
    )
    
  )
  
)


shinyApp(ui = ui, server = server)