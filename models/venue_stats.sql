MODEL (
  name ipl_data.venue_stats,
  kind FULL
);

SELECT
  venue,
  COUNT(DISTINCT match_id) AS total_matches,
  SUM(CASE WHEN win_outcome LIKE '%wickets%' THEN 1 ELSE 0 END) AS chases_won,
  SUM(CASE WHEN win_outcome LIKE '%runs%' THEN 1 ELSE 0 END) AS defended,
  ROUND(
    SUM(CASE WHEN win_outcome LIKE '%wickets%' THEN 1 ELSE 0 END) * 100.0 /
    NULLIF(COUNT(DISTINCT match_id), 0), 2
  ) AS chase_success_rate
FROM ipl_data.match_summary
GROUP BY venue