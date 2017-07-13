library(Lahman)
library(RODBC)
library(ggplot2)
require(dyplr)

query = "SELECT [playerID]
          ,[yearID]
          ,max([stint]) as num_stints
          ,count([POS]) as num_positions
          ,sum([G]) as G
          ,sum(coalesce([GS], 0)) as GS
          ,sum(coalesce([InnOuts], 0)) as InnOuts
          ,sum([PO]) as PO
          ,sum([A]) as A
          ,sum([E]) as E
          ,sum([DP]) as DP
          ,sum(coalesce([PB], 0)) as PB
          ,sum(coalesce([WP], 0)) as WP
          ,sum(coalesce([SB], 0)) as SB
          ,sum(coalesce([CS], 0)) as CS
          ,sum(coalesce([ZR], 0)) as ZR
          ,max(case when POS = 'C' then 1 else 0 end) as is_catcher
          ,max(case when POS = 'P' then 1 else 0 end) as is_pitcher
          FROM Fielding as f
          group by [playerID],[yearID]"


dbhandle <- odbcDriverConnect('driver={SQL Server};server=DESKTOP-PM6C8DF\\SQLEXPRESS;database=lahman;trusted_connection=true')
res <- sqlQuery(dbhandle, query)
#res[res$yearID == 2013,]

ggplot(aes(x = num_positions), data = res) +
  geom_histogram(binwidth = 1)



