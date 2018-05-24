SELECT
  t_batter.batter_id AS batter_id,
  t_players.mlb_name AS batter_name,
  t_batter.batter_team AS batter_team,
  t_batter.game_year AS year,
  t_batter.avg_exit_velocity AS avg_exit_velocity,
  t_batter.max_exit_velocity AS max_exit_velocity,
  t_batter.std_exit_velocity AS std_exit_velocity,
  t_batter.batted_balls AS batted_balls,
  t_batter.woba AS woba
FROM
  (
    SELECT
      batter AS batter_id,
      game_year AS game_year,
      batter_team AS batter_team,
      AVG(launch_speed) AS avg_exit_velocity,
      MAX(launch_speed) AS max_exit_velocity,
      STDDEV(launch_speed) AS std_exit_velocity,
      COUNT(launch_speed) AS batted_balls,
      SUM(woba_value) / SUM(woba_denom) AS woba
    FROM
      `mlbdb`.`statcast_extended`
    WHERE
    	game_year = 2018
    GROUP BY 1, 2, 3
  ) t_batter
    LEFT OUTER JOIN
  (
    SELECT
      mlb_id,
      mlb_name
    FROM
      `mlbdb`.`players`
  ) t_players
    ON (t_batter.batter_id = t_players.mlb_id)
WHERE
	t_batter.batted_balls > 25
ORDER BY woba DESC
LIMIT 100
