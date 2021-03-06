use lahman

begin try drop table #players end try begin catch print 'Cannot drop table' end catch

SELECT f.playerID
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
into #players
FROM Fielding as f
left join AwardsPlayers as ap 
	on f.playerID = ap.playerID
	and f.yearID = ap.yearID
	and ap.awardID = 'Gold Glove'
where 1=1
	--and f.yearID = 2013
	and f.yearID >= 1957
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
select * from Fielding where playerID = 'elmorja01' and yearID = 2013
select * from Fielding where ZR is not null


select playerID, yearID, count(distinct POS) as num_pos
from Fielding
group by playerID, yearID
having count(distinct POS) > 1
order by count(distinct POS) desc, yearID desc