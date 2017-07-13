use lahman

begin try drop table #players end try begin catch print 'Cannot drop table' end catch

SELECT [playerID]
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
into #players
FROM Fielding as f
where f.yearID = 2013
group by [playerID],[yearID]


select p.*
	,case when ap.awardID is null then 0 else 1 end as won_gg
	,ap.lgID as gg_league
	,ap.notes as gg_pos
from #players as p
left join AwardsPlayers as ap 
	on p.playerID = ap.playerID
	and p.yearID = ap.yearID
	and ap.awardID = 'Gold Glove'
order by playerID



--select * from #players order by playerID
select distinct awardID from AwardsPlayers order by awardID
select * from AwardsPlayers
select count(*), count(distinct playerID) from #players
select * from Fielding where playerID = 'abreuto01'