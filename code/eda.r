library(RODBC)
library(ggplot2)
require(dyplr)

query = "SELECT f.playerID
            ,f.yearID
            ,max(f.stint) as num_stints
            ,count(f.POS) as num_positions
            ,sum(coalesce(f.G, 0)) as games
            ,sum(coalesce(f.GS, 0)) as games_started
            ,sum(coalesce(f.InnOuts, 0)) as outs_played
            ,sum(coalesce(f.PO, 0)) as put_outs
            ,sum(coalesce(f.A, 0)) as assists
            ,sum(coalesce(f.E, 0)) as errors
            ,sum(coalesce(f.DP, 0)) as double_plays
            ,sum(coalesce(f.PB, 0)) as passed_balls
            ,sum(coalesce(f.WP, 0)) as wild_pitches
            ,sum(coalesce(f.SB, 0)) as opponent_stolen_bases
            ,sum(coalesce(f.CS, 0)) as opponent_caught_stealing
            ,sum(coalesce(f.ZR, 0)) as zone_rating
            ,max(case when f.POS = 'C' then 1 else 0 end) as is_catcher
            ,max(case when f.POS = 'P' then 1 else 0 end) as is_pitcher
            ,max(case when ap.awardID is null then 0 else 1 end) as won_gg
        FROM Fielding as f
        left join AwardsPlayers as ap 
          on f.playerID = ap.playerID
          and f.yearID = ap.yearID
          and ap.awardID = 'Gold Glove'
        where f.yearID >= 1957
        group by f.playerID, f.yearID"

plot_histogram <- function(var, df) {
  
  ggplot(aes_string(x = toString(var)), data = df) +
    geom_histogram(binwidth = 1) +
    scale_x_continuous(breaks = seq(1, max(df[toString(var)])))
  
}

dbhandle <- if (Sys.info()['nodename'] == "FD63STA001756") {
  
  odbcDriverConnect('driver={SQL Server};server=FD63STA001756\\JAC2;database=lahman;trusted_connection=true')

} else {
     
  odbcDriverConnect('driver={SQL Server};server=DESKTOP-PM6C8DF\\SQLEXPRESS;database=lahman;trusted_connection=true')

}

res <- sqlQuery(dbhandle, query)

plot_histogram("num_positions", res)
plot_histogram("outs_played", res)
plot_histogram("outs_played", res[res$won_gg == 1,])
plot_histogram("num_positions", res[res$won_gg == 1,])





res$labels = factor(res$won_gg, levels = c("0", "1"), labels = c("Population", "Gold Glove Winners"))
ggplot(aes(x = num_positions), data = res) +
  geom_histogram(binwidth = 1) +
  scale_x_continuous(breaks = seq(1, max(res$num_positions))) +
  geom_vline(aes(xintercept=median(res$num_positions),
                 color = "median"), linetype="solid", size=1) +
  facet_wrap(~labels, scales = "free_y", ncol = 1)





