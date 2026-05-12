MODEL (
  name ipl_data.match_summary,
  kind FULL
);

SELECT
  match_id,
  season,
  date,
  venue,
  city,
  CASE 
    WHEN batting_team = 'Royal Challengers Bengaluru' THEN 'Royal Challengers Bangalore'
    WHEN batting_team = 'Rising Pune Supergiant' THEN 'Rising Pune Supergiants'
    WHEN batting_team = 'Delhi Daredevils' THEN 'Delhi Capitals'
    WHEN batting_team = 'Punjab Kings' THEN 'Kings XI Punjab'
    ELSE batting_team 
  END AS batting_team,
  CASE 
    WHEN bowling_team = 'Royal Challengers Bengaluru' THEN 'Royal Challengers Bangalore'
    WHEN bowling_team = 'Rising Pune Supergiant' THEN 'Rising Pune Supergiants'
    WHEN bowling_team = 'Delhi Daredevils' THEN 'Delhi Capitals'
    WHEN bowling_team = 'Punjab Kings' THEN 'Kings XI Punjab'
    ELSE bowling_team 
  END AS bowling_team,
  toss_winner,
  toss_decision,
  CASE 
    WHEN match_won_by = 'Royal Challengers Bengaluru' THEN 'Royal Challengers Bangalore'
    WHEN match_won_by = 'Rising Pune Supergiant' THEN 'Rising Pune Supergiants'
    WHEN match_won_by = 'Delhi Daredevils' THEN 'Delhi Capitals'
    WHEN match_won_by = 'Punjab Kings' THEN 'Kings XI Punjab'
    ELSE match_won_by 
  END AS match_won_by,
  win_outcome,
  player_of_match,
  stage
FROM ipl_data.ipl_deliveries
WHERE innings = 1
  AND over = 0
  AND ball_no = 0.1