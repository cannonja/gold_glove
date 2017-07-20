use lahman
go

alter procedure usp_FIELDING_CONSOLIDATED

as
begin

	begin try drop table #fielders end try begin catch print 'Cannot drop table' end catch

	SELECT f.playerID
		  ,f.yearID
		  ,f.POS as position
		  ,(select max(f2.stint) 
			from Fielding as f2
			where f2.playerID = f.playerID 
				and f2.yearID = f.yearID
				and f2.playerID not in (select distinct playerID from FieldingOFsplit)) as num_stints		  
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
	into #fielders
	FROM Fielding as f
	where 1=1
		--and f.POS != 'OF'
		and f.playerID not in (select distinct playerID from FieldingOFsplit)
	group by f.playerID, f.yearID, f.POS

	union

	SELECT f.playerID
		  ,f.yearID
		  ,f.POS as position
		  ,(select max(f2.stint) 
			from Fielding as f2 
			where f2.playerID = f.playerID 
				and f2.yearID = f.yearID) as num_stints	
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
	from FieldingOFsplit as f
	group by f.playerID, f.yearID, f.POS
















	begin try drop table FIELDING_CONSOLIDATED end try begin catch print 'Cannot drop table' end catch

	select *
	into FIELDING_CONSOLIDATED
	from #fielders

end
go


/*** Testing and debugging *****/

--select * from Fielding where playerID = 'streega01' and yearID = 1905
--select * from #fielders where playerID = 'streega01' and yearID = 1905

--select count(distinct playerID) as players from Fielding where playerID not in (select distinct playerID from FieldingOFsplit)
--select count(distinct playerID) as players from FieldingOFsplit
--select count(distinct playerID) as players from Fielding
--select count(distinct playerID) as players from #fielders


--select * from Fielding where playerID not in (select distinct playerID from #fielders)

--select * from FieldingOFsplit where playerID in
--(select distinct playerID from Fielding where playerID not in (select distinct playerID from #fielders))

