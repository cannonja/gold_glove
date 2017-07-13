library(Lahman)
library(RODBC)
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
res[res$yearID == 2013,]



data(Fielding)
subset(Fielding, yearID == 2013) %>%
  group_by(playerID, yearID) %>%
  summarise(num_stints = max(stint), num_positions = sum(!is.na(POS)),
            G = sum(G), GS = sum(ifelse(is.na(GS), 0, GS)), InnOuts = sum(InnOuts), PO = sum(PO),
            A = sum(A), E = sum(E), DP = sum(DP), PB = sum(PB), WP = sum(WP),
            SB = sum(SB), CS = sum(CS), ZR = sum(ZR))

subset(Fielding, yearID == 2013 & playerID == 'abreuto01')