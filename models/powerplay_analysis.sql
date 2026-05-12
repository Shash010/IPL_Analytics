MODEL (
  name ipl_data.powerplay_analysis,
  kind FULL
);

SELECT
  season,
  batting_team,
  match_id,
  SUM(CASE WHEN over BETWEEN 0 AND 5 THEN runs_total ELSE 0 END) AS powerplay_runs,
  SUM(CASE WHEN over BETWEEN 0 AND 5 THEN bowler_wicket ELSE 0 END) AS powerplay_wickets,
  SUM(CASE WHEN over BETWEEN 16 AND 19 THEN runs_total ELSE 0 END) AS death_runs,
  SUM(CASE WHEN over BETWEEN 16 AND 19 THEN bowler_wicket ELSE 0 END) AS death_wickets,
  SUM(CASE WHEN over BETWEEN 6 AND 15 THEN runs_total ELSE 0 END) AS middle_runs,
  SUM(CASE WHEN over BETWEEN 6 AND 15 THEN bowler_wicket ELSE 0 END) AS middle_wickets
FROM ipl_data.ipl_deliveries
WHERE innings = 1
GROUP BY season, batting_team, match_id