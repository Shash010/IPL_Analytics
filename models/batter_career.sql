MODEL (
  name ipl_data.batter_career,
  kind FULL
);

SELECT
  batter,
  season,
  batting_team,
  COUNT(DISTINCT match_id) AS matches,
  SUM(runs_batter) AS total_runs,
  MAX(runs_batter) AS highest_score,
  SUM(CASE WHEN runs_batter = 4 THEN 1 ELSE 0 END) AS fours,
  SUM(CASE WHEN runs_batter = 6 THEN 1 ELSE 0 END) AS sixes,
  COUNT(*) AS balls_faced,
  ROUND(SUM(runs_batter) * 100.0 / NULLIF(COUNT(*), 0), 2) AS strike_rate,
  ROUND(SUM(runs_batter) * 1.0 / NULLIF(COUNT(DISTINCT match_id), 0), 2) AS avg_per_match
FROM ipl_data.ipl_deliveries
WHERE valid_ball = 1
GROUP BY batter, season, batting_team