use lahman

begin try drop table #players end try begin catch print 'Cannot drop table' end catch

SELECT f.playerID
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
into #players
FROM Fielding as f
left join AwardsPlayers as ap 
	on f.playerID = ap.playerID
	and f.yearID = ap.yearID
	and ap.awardID = 'Gold Glove'
where f.yearID = 2013
group by f.playerID, f.yearID


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