MODEL (
  name ipl_data.batting_stats,
  kind FULL
);

SELECT
  season,
  batter,
  batting_team,
  COUNT(*) as balls_faced,
  SUM(runs_batter) as total_runs,
  SUM(CASE WHEN runs_batter = 4 THEN 1 ELSE 0 END) as fours,
  SUM(CASE WHEN runs_batter = 6 THEN 1 ELSE 0 END) as sixes,
  ROUND(SUM(runs_batter) * 100.0 / COUNT(*), 2) as strike_rate
FROM ipl_data.ipl_deliveries
WHERE valid_ball = 1
GROUP BY season, batter, batting_team