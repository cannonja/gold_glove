library(Lahman)
library(RODBC)
library(ggplot2)
require(dyplr)

query = "SELECT f.playerID
            ,f.yearID
            ,max(f.stint) as num_stints
            ,count(f.POS) as num_positions
            ,sum(f.G) as G
            ,sum(coalesce(f.GS, 0)) as GS
            ,sum(coalesce(f.InnOuts, 0)) as InnOuts
            ,sum(f.PO) as PO
            ,sum(f.A) as A
            ,sum(f.E) as E
            ,sum(f.DP) as DP
            ,sum(coalesce(f.PB, 0)) as PB
            ,sum(coalesce(f.WP, 0)) as WP
            ,sum(coalesce(f.SB, 0)) as SB
            ,sum(coalesce(f.CS, 0)) as CS
            ,sum(coalesce(f.ZR, 0)) as ZR
            ,max(case when f.POS = 'C' then 1 else 0 end) as is_catcher
            ,max(case when f.POS = 'P' then 1 else 0 end) as is_pitcher
            ,max(case when ap.awardID is null then 0 else 1 end) as won_gg
        FROM Fielding as f
        left join AwardsPlayers as ap 
          on f.playerID = ap.playerID
          and f.yearID = ap.yearID
          and ap.awardID = 'Gold Glove'
        group by f.playerID, f.yearID"


dbhandle <- odbcDriverConnect('driver={SQL Server};server=DESKTOP-PM6C8DF\\SQLEXPRESS;database=lahman;trusted_connection=true')
res <- sqlQuery(dbhandle, query)
#res[res$yearID == 2013,]

ggplot(aes(x = num_positions), data = res) +
  geom_histogram(binwidth = 1) +
  scale_x_continuous(breaks = seq(1, max(res$num_positions))) +
  facet_wrap(~won_gg)



