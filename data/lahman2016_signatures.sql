use lahman
-- ----------------------------
--  Table structure for [AllstarFull]
-- ----------------------------
BEGIN TRY DROP TABLE [AllstarFull] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [AllstarFull] (
  [playerID] varchar(255) NULL,
  [yearID] int NULL,
  [gameNum] int NULL,
  [gameID] varchar(255) NULL,
  [teamID] varchar(255) NULL,
  [lgID] varchar(255) NULL,
  [GP] int NULL,
  [startingPos] varchar(255) NULL
)

-- ----------------------------
--  Table structure for [Appearances]
-- ----------------------------
BEGIN TRY DROP TABLE [Appearances] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [Appearances] (
  [yearID] int NULL,
  [teamID] varchar(255) NULL,
  [lgID] varchar(255) NULL,
  [playerID] varchar(255) NULL,
  [G_all] int NULL,
  [GS] int NULL,
  [G_batting] int NULL,
  [G_defense] int NULL,
  [G_p] int NULL,
  [G_c] int NULL,
  [G_1b] int NULL,
  [G_2b] int NULL,
  [G_3b] int NULL,
  [G_ss] int NULL,
  [G_lf] int NULL,
  [G_cf] int NULL,
  [G_rf] int NULL,
  [G_of] int NULL,
  [G_dh] int NULL,
  [G_ph] int NULL,
  [G_pr] int NULL
)



-- ----------------------------
--  Table structure for [AwardsManagers]
-- ----------------------------
BEGIN TRY DROP TABLE [AwardsManagers] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [AwardsManagers] (
  [playerID] varchar(255) NULL,
  [awardID] varchar(255) NULL,
  [yearID] int NULL,
  [lgID] varchar(255) NULL,
  [tie] varchar(255) NULL,
  [notes] varchar(255) NULL
)




-- ----------------------------
--  Table structure for [AwardsPlayers]
-- ----------------------------
BEGIN TRY DROP TABLE [AwardsPlayers] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [AwardsPlayers] (
  [playerID] varchar(255) NULL,
  [awardID] varchar(255) NULL,
  [yearID] int NULL,
  [lgID] varchar(255) NULL,
  [tie] varchar(255) NULL,
  [notes] varchar(255) NULL
)



-- ----------------------------
--  Table structure for [AwardsShareManagers]
-- ----------------------------
BEGIN TRY DROP TABLE [AwardsShareManagers] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [AwardsShareManagers] (
  [awardID] varchar(255) NULL,
  [yearID] int NULL,
  [lgID] varchar(255) NULL,
  [playerID] varchar(255) NULL,
  [pointsWon] int NULL,
  [pointsMax] int NULL,
  [votesFirst] int NULL
)



-- ----------------------------
--  Table structure for [AwardsSharePlayers]
-- ----------------------------
BEGIN TRY DROP TABLE [AwardsSharePlayers] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [AwardsSharePlayers] (
  [awardID] varchar(255) NULL,
  [yearID] int NULL,
  [lgID] varchar(255) NULL,
  [playerID] varchar(255) NULL,
  [pointsWon] int NULL,
  [pointsMax] int NULL,
  [votesFirst] int NULL
)



-- ----------------------------
--  Table structure for [Batting]
-- ----------------------------
BEGIN TRY DROP TABLE [Batting] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [Batting] (
  [playerID] varchar(255) NULL,
  [yearID] int NULL,
  [stint] int NULL,
  [teamID] varchar(255) NULL,
  [lgID] varchar(255) NULL,
  [G] int NULL,
  [AB] int NULL,
  [R] int NULL,
  [H] int NULL,
  [2B] int NULL,
  [3B] int NULL,
  [HR] int NULL,
  [RBI] int NULL,
  [SB] int NULL,
  [CS] int NULL,
  [BB] int NULL,
  [SO] int NULL,
  [IBB] int NULL,
  [HBP] int NULL,
  [SH] int NULL,
  [SF] int NULL,
  [GIDP] int NULL
)



-- ----------------------------
--  Table structure for [BattingPost]
-- ----------------------------
BEGIN TRY DROP TABLE [BattingPost] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [BattingPost] (
  [yearID] int NULL,
  [round] varchar(255) NULL,
  [playerID] varchar(255) NULL,
  [teamID] varchar(255) NULL,
  [lgID] varchar(255) NULL,
  [G] int NULL,
  [AB] int NULL,
  [R] int NULL,
  [H] int NULL,
  [2B] int NULL,
  [3B] int NULL,
  [HR] int NULL,
  [RBI] int NULL,
  [SB] int NULL,
  [CS] int NULL,
  [BB] int NULL,
  [SO] int NULL,
  [IBB] int NULL,
  [HBP] int NULL,
  [SH] int NULL,
  [SF] int NULL,
  [GIDP] int NULL
)


-- ----------------------------
--  Table structure for [CollegePlaying]
-- ----------------------------
BEGIN TRY DROP TABLE [CollegePlaying] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [CollegePlaying] (
  [playerID] varchar(255) NULL,
  [schoolID] varchar(255) NULL,
  [yearID] int NULL
)



-- ----------------------------
--  Table structure for [Fielding]
-- ----------------------------
BEGIN TRY DROP TABLE [Fielding] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [Fielding] (
  [playerID] varchar(255) NULL,
  [yearID] int NULL,
  [stint] int NULL,
  [teamID] varchar(255) NULL,
  [lgID] varchar(255) NULL,
  [POS] varchar(255) NULL,
  [G] int NULL,
  [GS] int NULL,
  [InnOuts] int NULL,
  [PO] int NULL,
  [A] int NULL,
  [E] int NULL,
  [DP] int NULL,
  [PB] int NULL,
  [WP] int NULL,
  [SB] int NULL,
  [CS] int NULL,
  [ZR] int NULL
)



-- ----------------------------
--  Table structure for [FieldingOF]
-- ----------------------------
BEGIN TRY DROP TABLE [FieldingOF] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [FieldingOF] (
  [playerID] varchar(255) NULL,
  [yearID] int NULL,
  [stint] int NULL,
  [Glf] int NULL,
  [Gcf] int NULL,
  [Grf] int NULL
)



-- ----------------------------
--  Table structure for [FieldingOFsplit]
-- ----------------------------
BEGIN TRY DROP TABLE [FieldingOFsplit] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [FieldingOFsplit] (
  [playerID] varchar(255) NULL,
  [yearID] int NULL,
  [stint] int NULL,
  [teamID] varchar(255) NULL,
  [lgID] varchar(255) NULL,
  [POS] varchar(255) NULL,
  [G] int NULL,
  [GS] int NULL,
  [InnOuts] int NULL,
  [PO] int NULL,
  [A] int NULL,
  [E] int NULL,
  [DP] int NULL,
  [PB] int NULL,
  [WP] int NULL,
  [SB] int NULL,
  [CS] int NULL,
  [ZR] int NULL
)



-- ----------------------------
--  Table structure for [FieldingPost]
-- ----------------------------
BEGIN TRY DROP TABLE [FieldingPost] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [FieldingPost] (
  [playerID] varchar(255) NULL,
  [yearID] int NULL,
  [teamID] varchar(255) NULL,
  [lgID] varchar(255) NULL,
  [round] varchar(255) NULL,
  [POS] varchar(255) NULL,
  [G] int NULL,
  [GS] int NULL,
  [InnOuts] int NULL,
  [PO] int NULL,
  [A] int NULL,
  [E] int NULL,
  [DP] int NULL,
  [TP] int NULL,
  [PB] int NULL,
  [SB] int NULL,
  [CS] int NULL
)



-- ----------------------------
--  Table structure for [HallOfFame]
-- ----------------------------
BEGIN TRY DROP TABLE [HallOfFame] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [HallOfFame] (
  [playerID] varchar(255) NULL,
  [yearid] int NULL,
  [votedBy] varchar(255) NULL,
  [ballots] int NULL,
  [needed] int NULL,
  [votes] int NULL,
  [inducted] varchar(255) NULL,
  [category] varchar(255) NULL,
  [needed_note] varchar(255) NULL
)



-- ----------------------------
--  Table structure for [HomeGames]
-- ----------------------------
BEGIN TRY DROP TABLE [HomeGames] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [HomeGames] (
  [year.key] int NULL,
  [league.key] varchar(255) NULL,
  [team.key] varchar(255) NULL,
  [park.key] varchar(255) NULL,
  [span.first] varchar(255) NULL,
  [span.last] varchar(255) NULL,
  [games] int NULL,
  [openings] int NULL,
  [attendance] int NULL
)



-- ----------------------------
--  Table structure for [Managers]
-- ----------------------------
BEGIN TRY DROP TABLE [Managers] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [Managers] (
  [playerID] varchar(255) NULL,
  [yearID] int NULL,
  [teamID] varchar(255) NULL,
  [lgID] varchar(255) NULL,
  [inseason] int NULL,
  [G] int NULL,
  [W] int NULL,
  [L] int NULL,
  [rank] int NULL,
  [plyrMgr] varchar(255) NULL
)



-- ----------------------------
--  Table structure for [ManagersHalf]
-- ----------------------------
BEGIN TRY DROP TABLE [ManagersHalf] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [ManagersHalf] (
  [playerID] varchar(255) NULL,
  [yearID] int NULL,
  [teamID] varchar(255) NULL,
  [lgID] varchar(255) NULL,
  [inseason] int NULL,
  [half] int NULL,
  [G] int NULL,
  [W] int NULL,
  [L] int NULL,
  [rank] int NULL
)



-- ----------------------------
--  Table structure for [Master]
-- ----------------------------
BEGIN TRY DROP TABLE [Master] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [Master] (
  [playerID] varchar(255) NULL,
  [birthYear] int NULL,
  [birthMonth] int NULL,
  [birthDay] int NULL,
  [birthCountry] varchar(255) NULL,
  [birthState] varchar(255) NULL,
  [birthCity] varchar(255) NULL,
  [deathYear] int NULL,
  [deathMonth] int NULL,
  [deathDay] int NULL,
  [deathCountry] varchar(255) NULL,
  [deathState] varchar(255) NULL,
  [deathCity] varchar(255) NULL,
  [nameFirst] varchar(255) NULL,
  [nameLast] varchar(255) NULL,
  [nameGiven] varchar(255) NULL,
  [weight] int NULL,
  [height] int NULL,
  [bats] varchar(255) NULL,
  [throws] varchar(255) NULL,
  [debut] varchar(255) NULL,
  [finalGame] varchar(255) NULL,
  [retroID] varchar(255) NULL,
  [bbrefID] varchar(255) NULL
)


-- ----------------------------
--  Table structure for [Parks]
-- ----------------------------
BEGIN TRY DROP TABLE [Parks] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [Parks] (
  [park.key] varchar(255) NULL,
  [park.name] varchar(255) NULL,
  [park.alias] varchar(255) NULL,
  [city] varchar(255) NULL,
  [state] varchar(255) NULL,
  [country] varchar(255) NULL
)



-- ----------------------------
--  Table structure for [Pitching]
-- ----------------------------
BEGIN TRY DROP TABLE [Pitching] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [Pitching] (
  [playerID] varchar(255) NULL,
  [yearID] int NULL,
  [stint] int NULL,
  [teamID] varchar(255) NULL,
  [lgID] varchar(255) NULL,
  [W] int NULL,
  [L] int NULL,
  [G] int NULL,
  [GS] int NULL,
  [CG] int NULL,
  [SHO] int NULL,
  [SV] int NULL,
  [IPouts] int NULL,
  [H] int NULL,
  [ER] int NULL,
  [HR] int NULL,
  [BB] int NULL,
  [SO] int NULL,
  [BAOpp] float NULL,
  [ERA] float NULL,
  [IBB] int NULL,
  [WP] int NULL,
  [HBP] int NULL,
  [BK] int NULL,
  [BFP] int NULL,
  [GF] int NULL,
  [R] int NULL,
  [SH] int NULL,
  [SF] int NULL,
  [GIDP] int NULL
)



-- ----------------------------
--  Table structure for [PitchingPost]
-- ----------------------------
BEGIN TRY DROP TABLE [PitchingPost] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [PitchingPost] (
  [playerID] varchar(255) NULL,
  [yearID] int NULL,
  [round] varchar(255) NULL,
  [teamID] varchar(255) NULL,
  [lgID] varchar(255) NULL,
  [W] int NULL,
  [L] int NULL,
  [G] int NULL,
  [GS] int NULL,
  [CG] int NULL,
  [SHO] int NULL,
  [SV] int NULL,
  [IPouts] int NULL,
  [H] int NULL,
  [ER] int NULL,
  [HR] int NULL,
  [BB] int NULL,
  [SO] int NULL,
  [BAOpp] float NULL,
  [ERA] float NULL,
  [IBB] int NULL,
  [WP] int NULL,
  [HBP] int NULL,
  [BK] int NULL,
  [BFP] int NULL,
  [GF] int NULL,
  [R] int NULL,
  [SH] int NULL,
  [SF] int NULL,
  [GIDP] int NULL
)



-- ----------------------------
--  Table structure for [Salaries]
-- ----------------------------
BEGIN TRY DROP TABLE [Salaries] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [Salaries] (
  [yearID] int NULL,
  [teamID] varchar(255) NULL,
  [lgID] varchar(255) NULL,
  [playerID] varchar(255) NULL,
  [salary] int NULL
)



-- ----------------------------
--  Table structure for [Schools]
-- ----------------------------
BEGIN TRY DROP TABLE [Schools] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [Schools] (
  [schoolID] varchar(255) NULL,
  [name_full] varchar(255) NULL,
  [city] varchar(255) NULL,
  [state] varchar(255) NULL,
  [country] varchar(255) NULL
)



-- ----------------------------
--  Table structure for [SeriesPost]
-- ----------------------------
BEGIN TRY DROP TABLE [SeriesPost] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [SeriesPost] (
  [yearID] int NULL,
  [round] varchar(255) NULL,
  [teamIDwinner] varchar(255) NULL,
  [lgIDwinner] varchar(255) NULL,
  [teamIDloser] varchar(255) NULL,
  [lgIDloser] varchar(255) NULL,
  [wins] int NULL,
  [losses] int NULL,
  [ties] int NULL
)



-- ----------------------------
--  Table structure for [Teams]
-- ----------------------------
BEGIN TRY DROP TABLE [Teams] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [Teams] (
  [yearID] int NULL,
  [lgID] varchar(255) NULL,
  [teamID] varchar(255) NULL,
  [franchID] varchar(255) NULL,
  [divID] varchar(255) NULL,
  [Rank] int NULL,
  [G] int NULL,
  [Ghome] int NULL,
  [W] int NULL,
  [L] int NULL,
  [DivWin] varchar(255) NULL,
  [WCWin] varchar(255) NULL,
  [LgWin] varchar(255) NULL,
  [WSWin] varchar(255) NULL,
  [R] int NULL,
  [AB] int NULL,
  [H] int NULL,
  [2B] int NULL,
  [3B] int NULL,
  [HR] int NULL,
  [BB] int NULL,
  [SO] int NULL,
  [SB] int NULL,
  [CS] int NULL,
  [HBP] int NULL,
  [SF] int NULL,
  [RA] int NULL,
  [ER] int NULL,
  [ERA] float NULL,
  [CG] int NULL,
  [SHO] int NULL,
  [SV] int NULL,
  [IPouts] int NULL,
  [HA] int NULL,
  [HRA] int NULL,
  [BBA] int NULL,
  [SOA] int NULL,
  [E] int NULL,
  [DP] int NULL,
  [FP] float NULL,
  [name] varchar(255) NULL,
  [park] varchar(255) NULL,
  [attendance] varchar(255) NULL,
  [BPF] int NULL,
  [PPF] int NULL,
  [teamIDBR] varchar(255) NULL,
  [teamIDlahman45] varchar(255) NULL,
  [teamIDretro] varchar(255) NULL
)



-- ----------------------------
--  Table structure for [TeamsFranchises]
-- ----------------------------
BEGIN TRY DROP TABLE [TeamsFranchises] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [TeamsFranchises] (
  [franchID] varchar(255) NULL,
  [franchName] varchar(255) NULL,
  [active] varchar(255) NULL,
  [NAassoc] varchar(255) NULL
)



-- ----------------------------
--  Table structure for [TeamsHalf]
-- ----------------------------
BEGIN TRY DROP TABLE [TeamsHalf] END TRY BEGIN CATCH PRINT 'CANNOT DROP TABLE' END CATCH

CREATE TABLE [TeamsHalf] (
  [yearID] int NULL,
  [lgID] varchar(255) NULL,
  [teamID] varchar(255) NULL,
  [Half] int NULL,
  [divID] varchar(255) NULL,
  [DivWin] varchar(255) NULL,
  [Rank] int NULL,
  [G] int NULL,
  [W] int NULL,
  [L] int NULL
)


