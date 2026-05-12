MODEL (
  name ipl_data.bowling_stats,
  kind FULL
);

SELECT
  season,
  bowler,
  bowling_team,
  COUNT(*) as balls_bowled,
  SUM(runs_bowler) as runs_conceded,
  SUM(bowler_wicket) as wickets,
  ROUND(SUM(runs_bowler) * 6.0 / COUNT(*), 2) as economy
FROM ipl_data.ipl_deliveries
WHERE valid_ball = 1
GROUP BY season, bowler, bowling_team