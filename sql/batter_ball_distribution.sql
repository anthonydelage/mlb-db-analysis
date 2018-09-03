SELECT
  t_bb.game_year AS game_year,
  t_players.mlb_id AS mlb_id,
  t_players.mlb_name AS mlb_name,
  t_players.fg_id AS fangraphs_id,
  t_bb.bb_events AS bb_events,
  t_bb.home_runs AS home_runs,
  ROUND(t_bb.home_runs / t_bb.bb_events, 3) AS hr_rate,
  (CASE WHEN t_bb.fly_events > 0 OR t_bb.line_events > 0
      THEN ROUND(t_bb.home_runs / (t_bb.fly_events + t_bb.line_events), 3)
    ELSE 0 END) AS hr_air_rate,
  (CASE WHEN t_bb.fly_events > 0 THEN ROUND(t_bb.fly_home_runs / t_bb.fly_events, 3)
    ELSE 0 END) AS fly_hr_rate,
  (CASE WHEN t_bb.line_events > 0 THEN ROUND(t_bb.line_home_runs / t_bb.line_events, 3)
    ELSE 0 END) AS line_hr_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.fly_events / t_bb.bb_events, 3)
    ELSE 0 END) AS fly_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.line_events / t_bb.bb_events, 3)
    ELSE 0 END) AS line_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.ground_events / t_bb.bb_events, 3)
    ELSE 0 END) AS ground_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.pop_events / t_bb.bb_events, 3)
    ELSE 0 END) AS pop_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.fly_pull_events / t_bb.bb_events, 3)
    ELSE 0 END) AS fly_pull_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.fly_center_events / t_bb.bb_events, 3)
    ELSE 0 END) AS fly_center_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.fly_oppo_events / t_bb.bb_events, 3)
    ELSE 0 END) AS fly_oppo_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.line_pull_events / t_bb.bb_events, 3)
    ELSE 0 END) AS line_pull_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.line_center_events / t_bb.bb_events, 3)
    ELSE 0 END) AS line_center_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.line_oppo_events / t_bb.bb_events, 3)
    ELSE 0 END) AS line_oppo_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.ground_pull_events / t_bb.bb_events, 3)
    ELSE 0 END) AS ground_pull_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.ground_center_events / t_bb.bb_events, 3)
    ELSE 0 END) AS ground_center_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.ground_oppo_events / t_bb.bb_events, 3)
    ELSE 0 END) AS ground_oppo_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.pop_pull_events / t_bb.bb_events, 3)
    ELSE 0 END) AS pop_pull_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.pop_center_events / t_bb.bb_events, 3)
    ELSE 0 END) AS pop_center_rate,
  (CASE WHEN t_bb.bb_events > 0 THEN ROUND(t_bb.pop_oppo_events / t_bb.bb_events, 3)
    ELSE 0 END) AS pop_oppo_rate,
  t_bb.fly_events AS fly_events,
  t_bb.line_events AS line_events,
  t_bb.ground_events AS ground_events,
  t_bb.pop_events AS pop_events,
  t_bb.fly_pull_events AS fly_pull_events,
  t_bb.fly_center_events AS fly_center_events,
  t_bb.fly_oppo_events AS fly_oppo_events,
  t_bb.line_pull_events AS line_pull_events,
  t_bb.line_center_events AS line_center_events,
  t_bb.line_oppo_events AS line_oppo_events,
  t_bb.ground_pull_events AS ground_pull_events,
  t_bb.ground_center_events AS ground_center_events,
  t_bb.ground_oppo_events AS ground_oppo_events,
  t_bb.pop_pull_events AS pop_pull_events,
  t_bb.pop_center_events AS pop_center_events,
  t_bb.pop_oppo_events AS pop_oppo_events,
  t_bb.fly_max_exit_velo AS fly_max_exit_velo,
  t_bb.fly_p75_exit_velo AS fly_p75_exit_velo,
  t_bb.fly_p90_exit_velo AS fly_p90_exit_velo,
  t_bb.fly_p95_exit_velo AS fly_p95_exit_velo,
  t_bb.fly_pull_max_exit_velo AS fly_pull_max_exit_velo,
  t_bb.fly_pull_p75_exit_velo AS fly_pull_p75_exit_velo,
  t_bb.fly_pull_p90_exit_velo AS fly_pull_p90_exit_velo,
  t_bb.fly_pull_p95_exit_velo AS fly_pull_p95_exit_velo,
  t_bb.fly_center_max_exit_velo AS fly_center_max_exit_velo,
  t_bb.fly_center_p75_exit_velo AS fly_center_p75_exit_velo,
  t_bb.fly_center_p90_exit_velo AS fly_center_p90_exit_velo,
  t_bb.fly_center_p95_exit_velo AS fly_center_p95_exit_velo,
  t_bb.fly_oppo_max_exit_velo AS fly_oppo_max_exit_velo,
  t_bb.fly_oppo_p75_exit_velo AS fly_oppo_p75_exit_velo,
  t_bb.fly_oppo_p90_exit_velo AS fly_oppo_p90_exit_velo,
  t_bb.fly_oppo_p95_exit_velo AS fly_oppo_p95_exit_velo,
  t_bb.line_max_exit_velo AS line_max_exit_velo,
  t_bb.line_p75_exit_velo AS line_p75_exit_velo,
  t_bb.line_p90_exit_velo AS line_p90_exit_velo,
  t_bb.line_p95_exit_velo AS line_p95_exit_velo,
  t_bb.line_pull_max_exit_velo AS line_pull_max_exit_velo,
  t_bb.line_pull_p75_exit_velo AS line_pull_p75_exit_velo,
  t_bb.line_pull_p90_exit_velo AS line_pull_p90_exit_velo,
  t_bb.line_pull_p95_exit_velo AS line_pull_p95_exit_velo,
  t_bb.line_center_max_exit_velo AS line_center_max_exit_velo,
  t_bb.line_center_p75_exit_velo AS line_center_p75_exit_velo,
  t_bb.line_center_p90_exit_velo AS line_center_p90_exit_velo,
  t_bb.line_center_p95_exit_velo AS line_center_p95_exit_velo,
  t_bb.line_oppo_max_exit_velo AS line_oppo_max_exit_velo,
  t_bb.line_oppo_p75_exit_velo AS line_oppo_p75_exit_velo,
  t_bb.line_oppo_p90_exit_velo AS line_oppo_p90_exit_velo,
  t_bb.line_oppo_p95_exit_velo AS line_oppo_p95_exit_velo,
  t_bb.ground_max_exit_velo AS ground_max_exit_velo,
  t_bb.ground_p75_exit_velo AS ground_p75_exit_velo,
  t_bb.ground_p90_exit_velo AS ground_p90_exit_velo,
  t_bb.ground_p95_exit_velo AS ground_p95_exit_velo,
  t_bb.ground_pull_max_exit_velo AS ground_pull_max_exit_velo,
  t_bb.ground_pull_p75_exit_velo AS ground_pull_p75_exit_velo,
  t_bb.ground_pull_p90_exit_velo AS ground_pull_p90_exit_velo,
  t_bb.ground_pull_p95_exit_velo AS ground_pull_p95_exit_velo,
  t_bb.ground_center_max_exit_velo AS ground_center_max_exit_velo,
  t_bb.ground_center_p75_exit_velo AS ground_center_p75_exit_velo,
  t_bb.ground_center_p90_exit_velo AS ground_center_p90_exit_velo,
  t_bb.ground_center_p95_exit_velo AS ground_center_p95_exit_velo,
  t_bb.ground_oppo_max_exit_velo AS ground_oppo_max_exit_velo,
  t_bb.ground_oppo_p75_exit_velo AS ground_oppo_p75_exit_velo,
  t_bb.ground_oppo_p90_exit_velo AS ground_oppo_p90_exit_velo,
  t_bb.ground_oppo_p95_exit_velo AS ground_oppo_p95_exit_velo
FROM
  (
    SELECT
      game_year,
      batter_id,
      COALESCE(SUM(bb_events), 0) AS bb_events,
      COALESCE(SUM(home_runs), 0) AS home_runs,
      COALESCE(SUM(CASE WHEN bb_type = 'fly_ball' THEN home_runs END), 0) AS fly_home_runs,
      COALESCE(SUM(CASE WHEN bb_type = 'line_drive' THEN home_runs END), 0) AS line_home_runs,
      COALESCE(SUM(CASE WHEN bb_type = 'fly_ball' THEN bb_events END), 0) AS fly_events,
      COALESCE(SUM(CASE WHEN bb_type = 'line_drive' THEN bb_events END), 0) AS line_events,
      COALESCE(SUM(CASE WHEN bb_type = 'ground_ball' THEN bb_events END), 0) AS ground_events,
      COALESCE(SUM(CASE WHEN bb_type = 'popup' THEN bb_events END), 0) AS pop_events,
      COALESCE(SUM(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'pull' THEN bb_events END), 0) AS fly_pull_events,
      COALESCE(SUM(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'center' THEN bb_events END), 0) AS fly_center_events,
      COALESCE(SUM(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'oppo' THEN bb_events END), 0) AS fly_oppo_events,
      COALESCE(SUM(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'pull' THEN bb_events END), 0) AS line_pull_events,
      COALESCE(SUM(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'center' THEN bb_events END), 0) AS line_center_events,
      COALESCE(SUM(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'oppo' THEN bb_events END), 0) AS line_oppo_events,
      COALESCE(SUM(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'pull' THEN bb_events END), 0) AS ground_pull_events,
      COALESCE(SUM(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'center' THEN bb_events END), 0) AS ground_center_events,
      COALESCE(SUM(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'oppo' THEN bb_events END), 0) AS ground_oppo_events,
      COALESCE(SUM(CASE WHEN bb_type = 'popup' AND bb_direction = 'pull' THEN bb_events END), 0) AS pop_pull_events,
      COALESCE(SUM(CASE WHEN bb_type = 'popup' AND bb_direction = 'center' THEN bb_events END), 0) AS pop_center_events,
      COALESCE(SUM(CASE WHEN bb_type = 'popup' AND bb_direction = 'oppo' THEN bb_events END), 0) AS pop_oppo_events,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' THEN max_exit_velo END), 0) AS fly_max_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' THEN exit_velo_percentiles[OFFSET(75)] END), 0) AS fly_p75_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' THEN exit_velo_percentiles[OFFSET(90)] END), 0) AS fly_p90_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' THEN exit_velo_percentiles[OFFSET(95)] END), 0) AS fly_p95_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'pull' THEN max_exit_velo END), 0) AS fly_pull_max_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'pull' THEN exit_velo_percentiles[OFFSET(75)] END), 0) AS fly_pull_p75_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'pull' THEN exit_velo_percentiles[OFFSET(90)] END), 0) AS fly_pull_p90_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'pull' THEN exit_velo_percentiles[OFFSET(95)] END), 0) AS fly_pull_p95_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'center' THEN max_exit_velo END), 0) AS fly_center_max_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'center' THEN exit_velo_percentiles[OFFSET(75)] END), 0) AS fly_center_p75_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'center' THEN exit_velo_percentiles[OFFSET(90)] END), 0) AS fly_center_p90_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'center' THEN exit_velo_percentiles[OFFSET(95)] END), 0) AS fly_center_p95_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'oppo' THEN max_exit_velo END), 0) AS fly_oppo_max_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'oppo' THEN exit_velo_percentiles[OFFSET(75)] END), 0) AS fly_oppo_p75_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'oppo' THEN exit_velo_percentiles[OFFSET(90)] END), 0) AS fly_oppo_p90_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'fly_ball' AND bb_direction = 'oppo' THEN exit_velo_percentiles[OFFSET(95)] END), 0) AS fly_oppo_p95_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' THEN max_exit_velo END), 0) AS line_max_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' THEN exit_velo_percentiles[OFFSET(75)] END), 0) AS line_p75_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' THEN exit_velo_percentiles[OFFSET(90)] END), 0) AS line_p90_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' THEN exit_velo_percentiles[OFFSET(95)] END), 0) AS line_p95_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'pull' THEN max_exit_velo END), 0) AS line_pull_max_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'pull' THEN exit_velo_percentiles[OFFSET(75)] END), 0) AS line_pull_p75_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'pull' THEN exit_velo_percentiles[OFFSET(90)] END), 0) AS line_pull_p90_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'pull' THEN exit_velo_percentiles[OFFSET(95)] END), 0) AS line_pull_p95_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'center' THEN max_exit_velo END), 0) AS line_center_max_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'center' THEN exit_velo_percentiles[OFFSET(75)] END), 0) AS line_center_p75_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'center' THEN exit_velo_percentiles[OFFSET(90)] END), 0) AS line_center_p90_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'center' THEN exit_velo_percentiles[OFFSET(95)] END), 0) AS line_center_p95_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'oppo' THEN max_exit_velo END), 0) AS line_oppo_max_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'oppo' THEN exit_velo_percentiles[OFFSET(75)] END), 0) AS line_oppo_p75_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'oppo' THEN exit_velo_percentiles[OFFSET(90)] END), 0) AS line_oppo_p90_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'line_drive' AND bb_direction = 'oppo' THEN exit_velo_percentiles[OFFSET(95)] END), 0) AS line_oppo_p95_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' THEN max_exit_velo END), 0) AS ground_max_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' THEN exit_velo_percentiles[OFFSET(75)] END), 0) AS ground_p75_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' THEN exit_velo_percentiles[OFFSET(90)] END), 0) AS ground_p90_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' THEN exit_velo_percentiles[OFFSET(95)] END), 0) AS ground_p95_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'pull' THEN max_exit_velo END), 0) AS ground_pull_max_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'pull' THEN exit_velo_percentiles[OFFSET(75)] END), 0) AS ground_pull_p75_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'pull' THEN exit_velo_percentiles[OFFSET(90)] END), 0) AS ground_pull_p90_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'pull' THEN exit_velo_percentiles[OFFSET(95)] END), 0) AS ground_pull_p95_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'center' THEN max_exit_velo END), 0) AS ground_center_max_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'center' THEN exit_velo_percentiles[OFFSET(75)] END), 0) AS ground_center_p75_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'center' THEN exit_velo_percentiles[OFFSET(90)] END), 0) AS ground_center_p90_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'center' THEN exit_velo_percentiles[OFFSET(95)] END), 0) AS ground_center_p95_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'oppo' THEN max_exit_velo END), 0) AS ground_oppo_max_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'oppo' THEN exit_velo_percentiles[OFFSET(75)] END), 0) AS ground_oppo_p75_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'oppo' THEN exit_velo_percentiles[OFFSET(90)] END), 0) AS ground_oppo_p90_exit_velo,
      COALESCE(MAX(CASE WHEN bb_type = 'ground_ball' AND bb_direction = 'oppo' THEN exit_velo_percentiles[OFFSET(95)] END), 0) AS ground_oppo_p95_exit_velo
    FROM
      (
        SELECT
          EXTRACT(YEAR FROM game_date) AS game_year,
          batter AS batter_id,
          bb_type AS bb_type,
          (CASE WHEN (spray_angle_est < -15 AND stand = 'R') OR (spray_angle_est > 15 AND stand = 'L') THEN 'pull'
                WHEN (spray_angle_est < -15 AND stand = 'L') OR (spray_angle_est > 15 AND stand = 'R') THEN 'oppo'
                WHEN spray_angle_est BETWEEN -15 AND 15 THEN 'center'
                ELSE 'no-angle'
          END) AS bb_direction,
          COUNT(*) AS bb_events,
          SUM(CASE WHEN events = 'home_run' THEN 1 END) AS home_runs,
          APPROX_QUANTILES(launch_speed, 100) AS exit_velo_percentiles,
          MAX(launch_speed) AS max_exit_velo
        FROM
          `ad-fantasy-baseball.core.statcast_extended`
        WHERE
          game_type = 'R'
            AND type = 'X'
            AND NOT (events = 'field_out' AND REGEXP_CONTAINS(des, r'(?i)foul\sterritory'))
        GROUP BY 1, 2, 3, 4
      )
    GROUP BY 1, 2
    HAVING bb_events > 0
  ) t_bb
    LEFT OUTER JOIN
  (
    SELECT
      mlb_id,
      mlb_name,
      fg_id
    FROM
      `ad-fantasy-baseball.core.players`
    GROUP BY 1, 2, 3
  ) t_players
    ON (t_bb.batter_id = t_players.mlb_id)
ORDER BY 1