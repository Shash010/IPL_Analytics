MODEL (
  name ipl_data.team_performance,
  kind FULL
);

WITH all_matches AS (
  SELECT match_id, season, batting_team AS team, match_won_by, win_outcome
  FROM ipl_data.match_summary
  UNION ALL
  SELECT match_id, season, bowling_team AS team, match_won_by, win_outcome
  FROM ipl_data.match_summary
)

SELECT
  season,
  CASE
    WHEN team = 'Delhi Daredevils' THEN 'Delhi Capitals'
    WHEN team = 'Punjab Kings' THEN 'Kings XI Punjab'
    WHEN team = 'Royal Challengers Bengaluru' THEN 'Royal Challengers Bangalore'
    WHEN team = 'Rising Pune Supergiant' THEN 'Rising Pune Supergiants'
    ELSE team
  END AS team,
  COUNT(DISTINCT match_id) AS matches_played,
  SUM(CASE WHEN match_won_by = team THEN 1 ELSE 0 END) AS matches_won,
  SUM(CASE WHEN match_won_by != team AND win_outcome != 'no result' THEN 1 ELSE 0 END) AS matches_lost,
  ROUND(
    SUM(CASE WHEN match_won_by = team THEN 1 ELSE 0 END) * 100.0 / COUNT(DISTINCT match_id), 2
  ) AS win_percentage
FROM all_matches
GROUP BY season, team