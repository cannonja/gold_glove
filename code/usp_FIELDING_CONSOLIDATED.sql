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
		  ,sum(coalesce(f.SB, 0)) + sum(coalesce(f.CS, 0)) as opponent_steal_attempts
		  ,case when sum(coalesce(f.InnOuts, 0)) = 0 then sum(coalesce(f.InnOuts, 0))
			else round(sum(coalesce(f.ZR, 0) * coalesce(f.InnOuts, 0)) / sum(coalesce(f.InnOuts, 0)), 2) end as weighted_zr
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
		  ,sum(coalesce(f.SB, 0)) + sum(coalesce(f.CS, 0)) as opponent_steal_attempts
		  ,case when sum(coalesce(f.InnOuts, 0)) = 0 then sum(coalesce(f.InnOuts, 0))
			else round(sum(coalesce(f.ZR, 0) * coalesce(f.InnOuts, 0)) / sum(coalesce(f.InnOuts, 0)), 2) end as weighted_zr
		  ,max(case when f.POS = 'C' then 1 else 0 end) as is_catcher
		  ,max(case when f.POS = 'P' then 1 else 0 end) as is_pitcher
	from FieldingOFsplit as f
	group by f.playerID, f.yearID, f.POS


	/** Update outs played with outs pitched, games, games started ****/
	begin try drop table #add_pitchers end try begin catch print 'Cannot drop table' end catch

	select f.playerID
      ,f.yearID
      ,f.position
      ,f.num_stints
      ,sum(coalesce(case when f.position = 'P' then p.G else f.games end, 0)) as games
      ,sum(coalesce(case when f.position = 'P' then p.GS else f.games_started end, 0)) as games_started
      ,sum(coalesce(case when f.position = 'P' then p.IPOuts else f.outs_played end, 0)) as outs_played
      ,f.put_outs
      ,f.assists
      ,f.errors
      ,f.double_plays
      ,f.passed_balls
      ,sum(coalesce(case when f.position = 'P' then p.WP else f.wild_pitches end, 0)) as wild_pitches
      ,f.opponent_stolen_bases
      ,f.opponent_caught_stealing
	  ,f.opponent_steal_attempts
      ,f.weighted_zr
      ,f.is_catcher
      ,f.is_pitcher
	  ,sum(coalesce(p.W, 0)) as wins
	  ,sum(coalesce(p.L, 0)) as losses
	  ,sum(coalesce(p.CG, 0)) as complete_games
	  ,sum(coalesce(p.SHO, 0)) as shutouts
	  ,sum(coalesce(p.SV, 0)) as saves
	  ,sum(coalesce(p.H, 0)) as hits
	  ,sum(coalesce(p.ER, 0)) as earned_runs
	  ,sum(coalesce(p.HR, 0)) as homeruns
	  ,sum(coalesce(p.BB, 0)) as walks
	  ,sum(coalesce(p.SO, 0)) as strikeouts
	  ,case when sum(coalesce(p.IPouts, 0)) = 0 then sum(coalesce(p.IPouts, 0))
		else round(sum(coalesce(p.BAOpp, 0) * coalesce(p.IPouts, 0)) / sum(coalesce(p.IPouts, 0)), 3) end as weighted_opponent_ba  
	  ,case when sum(coalesce(p.IPouts, 0)) = 0 then sum(coalesce(p.IPouts, 0))
		else round(sum(coalesce(p.ERA, 0) * coalesce(p.IPouts, 0)) / sum(coalesce(p.IPouts, 0)), 2) end as weighted_era   
	  ,sum(coalesce(p.IBB, 0)) as intentional_walks
	  ,sum(coalesce(p.HBP, 0)) as batters_hit
	  ,sum(coalesce(p.BK, 0)) as balks
	  ,sum(coalesce(p.BFP, 0)) as batters_faced
	  ,sum(coalesce(p.GF, 0)) as games_finished
	  ,sum(coalesce(p.R, 0)) as runs_allowed
	  ,sum(coalesce(p.SH, 0)) as batter_sacrifices
	  ,sum(coalesce(p.SF, 0)) as batter_sac_flies
	  ,sum(coalesce(p.GIDP, 0)) as grounded_into_dp
	into #add_pitchers
	from #fielders as f
	left join Pitching as p
		on f.playerID = p.playerID
		and f.yearID = p.yearID
	group by f.playerID
      ,f.yearID
      ,f.position
      ,f.num_stints
      ,f.games
      ,f.games_started
      ,f.outs_played
      ,f.put_outs
      ,f.assists
      ,f.errors
      ,f.double_plays
      ,f.passed_balls
      ,f.opponent_stolen_bases
      ,f.opponent_caught_stealing
	  ,f.opponent_steal_attempts
      ,f.weighted_zr
      ,f.is_catcher
      ,f.is_pitcher

	begin try drop table FIELDING_CONSOLIDATED end try begin catch print 'Cannot drop table' end catch

	select p.*
		,case when ap.awardID is not null then 1 else 0 end as won_gg
		,case when ap.notes = 'OF' then 1 else 0 end as gen_OF_gg
	into FIELDING_CONSOLIDATED
	from #add_pitchers as p
	left join AwardsPlayers as ap 
		on p.playerID = ap.playerID
		and p.yearID = ap.yearID
		and ap.awardID = 'Gold Glove'
		and case when ap.notes = 'OF' and p.position in ('RF', 'LF', 'CF') then 'OF' else p.position end = ap.notes

end
go


/*** Testing and debugging *****/

--select * from Fielding where playerID = 'streega01' and yearID = 1905
--select * from #fielders where playerID = 'streega01' and yearID = 1905

--select count(distinct playerID) as players from Fielding where playerID not in (select distinct playerID from FieldingOFsplit)
--select count(distinct playerID) as players from FieldingOFsplit
--select count(distinct playerID) as players from Fielding
--select count(distinct playerID) as players from #fielders
--select count(distinct playerID) as players from #add_pitchers


--select * from Fielding where playerID not in (select distinct playerID from #fielders)

--select * from FieldingOFsplit where playerID in
--(select distinct playerID from Fielding where playerID not in (select distinct playerID from #fielders))

