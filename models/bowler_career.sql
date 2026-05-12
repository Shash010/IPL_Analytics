MODEL (
  name ipl_data.bowler_career,
  kind FULL
);

SELECT
  bowler,
  season,
  bowling_team,
  COUNT(DISTINCT match_id) AS matches,
  COUNT(*) AS balls_bowled,
  SUM(runs_bowler) AS runs_conceded,
  SUM(bowler_wicket) AS wickets,
  ROUND(SUM(runs_bowler) * 6.0 / NULLIF(COUNT(*), 0), 2) AS economy,
  ROUND(SUM(runs_bowler) * 1.0 / NULLIF(SUM(bowler_wicket), 0), 2) AS bowling_avg,
  ROUND(COUNT(*) * 1.0 / NULLIF(SUM(bowler_wicket), 0), 2) AS strike_rate
FROM ipl_data.ipl_deliveries
WHERE valid_ball = 1
GROUP BY bowler, season, bowling_team