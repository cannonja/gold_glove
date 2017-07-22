library(shinythemes)



required <- c("RODBC", "ggplot2")
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

query = "SELECT * FROM FIELDING_CONSOLIDATED WHERE yearID >= 1957"

plot_histogram <- function(var, df,  bw = 1, x_max = NULL) {
  
  pop_max <- if (is.null(x_max)) {max(df[toString(var)])} else {x_max}
  
  ggplot(aes_string(x = toString(var)), data = df) +
    geom_histogram(binwidth = bw, color = "black", fill = "#099DD9") +
    geom_vline(aes(xintercept=median(df[[toString(var)]]),
                   color = "median"), linetype="solid", size=1) +
    geom_vline(aes(xintercept=mean(df[[toString(var)]]),
                   color = "mean"), linetype="solid", size=1) +    
    scale_color_manual(name  = "Summary Stats", values=c(median = "blue", mean = "red")) +
    coord_cartesian(xlim = c(0, pop_max)) +
    scale_x_continuous(breaks = seq(0, pop_max, bw), minor_breaks = NULL, expand = c(0,0.75*bw)) +
    theme(axis.text.x = element_text(angle=90), legend.position = c(.9,.9))
  
}

dbhandle <- if (Sys.info()['nodename'] == "FD63STA001756") {
  
  odbcDriverConnect('driver={SQL Server};server=FD63STA001756\\JAC2;database=lahman;trusted_connection=true')
  
} else {
  
  odbcDriverConnect('driver={SQL Server};server=DESKTOP-PM6C8DF\\SQLEXPRESS;database=lahman;trusted_connection=true')
  
}

res <- sqlQuery(dbhandle, query)
res$labels = factor(res$won_gg, levels = c("0", "1"), labels = c("Population", "Gold Glove Winners"))


server <- function(input, output) {
  
  output$pop_plot <- renderPlot({
    
    pos <- input$pos
    
    df_in <- if (input$year_range) {
      subset(res, yearID >= input$years[1] & yearID <= input$years[2] & (position %in% pos))
    } else {
      subset(res, yearID == input$year & (position %in% pos))
    }
    
    plot_histogram(input$f_stat, df_in, input$bin_width)
    
  })
  
  output$gg_plot <- renderPlot({
    
    pos <- input$pos
    
    df_in <- if (input$year_range) {
      subset(res, yearID >= input$years[1] & yearID <= input$years[2] & (position %in% pos))
    } else {
      subset(res, yearID == input$year & (position %in% pos))
    }
    
    pop_max <- max(subset(df_in, select = input$f_stat))
    
    plot_histogram(input$f_stat, df_in[df_in$won_gg == 1,], input$bin_width, pop_max)
    
  })  
  
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
    
    column(3,
    
           selectInput("pos", label = "Select a position", choices = positions, selected = "SS"),
           br(),
           conditionalPanel(condition = "input.pos != 'P' && input.pos != 'C'",
                            selectInput("f_stat", label = "Select fielding stat", choices = fielding_stats, selected = "assists")),
           conditionalPanel(condition = "input.pos == 'C'",
                            selectInput("f_stat", label = "Select fielding stat", choices = fielding_stats_C, selected = "assists")),
           conditionalPanel(condition = "input.pos == 'P'",
                            selectInput("f_stat", label = "Select fielding stat", choices = fielding_stats_P, selected = "assists")),
           
           br(),
           checkboxInput("year_range", label = "Multi Year", value = FALSE),
           br(),
           conditionalPanel(condition = "input.year_range",
                            sliderInput("years", label = "Select Year Range", min  = min(res$yearID), max = max(res$yearID),
                                        value = c(2000, 2016), step = 1, sep = "")),
           conditionalPanel(condition = "!input.year_range",
                            selectInput("year", label = "Select Year", choices = seq(min(res$yearID), max(res$yearID)),
                                        selected = 2000)),
           br(),
           sliderInput("bin_width", label = "Select Bin Width", min = 1, max = 100, value = c(10), step = 1),
           shinythemes::themeSelector()
    ),
    
    column(9,
      
          plotOutput("pop_plot"),
          plotOutput("gg_plot")
      
    )
    
  )
  
)



shinyApp(ui = ui, server = server)