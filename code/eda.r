library(Lahman)
library(RODBC)
library(ggplot2)
require(dyplr)

query = "SELECT f.playerID
            ,f.yearID
            ,max(f.stint) as num_stints
            ,count(f.POS) as num_positions
            ,sum(f.G) as games
            ,sum(coalesce(f.GS, 0)) as games_started
            ,sum(coalesce(f.InnOuts, 0)) as outs_played
            ,sum(f.PO) as put_outs
            ,sum(f.A) as assists
            ,sum(f.E) as errors
            ,sum(f.DP) as double_plays
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
        group by f.playerID, f.yearID"

plot_histogram <- function(var, df) {
  
  ggplot(aes_string(x = toString(var)), data = df) +
    geom_histogram(binwidth = 1) +
    scale_x_continuous(breaks = seq(1, max(res[toString(var)])))
  
}

dbhandle <- if (Sys.info()['nodename'] == "FD63STA001756") {
  
  odbcDriverConnect('driver={SQL Server};server=FD63STA001756\\JAC2;database=lahman;trusted_connection=true')

} else {
     
  odbcDriverConnect('driver={SQL Server};server=DESKTOP-PM6C8DF\\SQLEXPRESS;database=lahman;trusted_connection=true')

}

res <- sqlQuery(dbhandle, query)







ggplot(aes(x = num_positions), data = res) +
  geom_histogram(binwidth = 1) +
  scale_x_continuous(breaks = seq(1, max(res$num_positions))) +
  facet_wrap(~won_gg)




