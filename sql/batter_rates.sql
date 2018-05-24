SELECT
  name,
  batter_id,
  plate_appearances,
  at_bats,
  (e_single + e_double + e_triple + e_home_run) / at_bats AS batting_avg,
  (e_single + e_double + e_triple + e_home_run + e_walk + e_hit_by_pitch) / (at_bats + e_walk + e_hit_by_pitch + e_sac_fly) AS on_base_pct,
  (e_single + 2 * e_double + 3 * e_triple + 4 * e_home_run) / at_bats AS slugging_pct,
  e_strikeout / plate_appearances AS k_rate,
  e_walk / plate_appearances AS bb_rate,
  e_home_run / plate_appearances AS hr_rate,
  e_home_run / b_fly_ball AS hr_fb_rate,
  b_ground_ball / plate_appearances AS gb_rate,
  b_line_drive / plate_appearances AS ld_rate,
  b_fly_ball / plate_appearances AS fb_rate,
  b_popup / plate_appearances AS pu_rate,
  d_called_strike / pitches AS castr_rate,
  (d_swinging_strike + d_swinging_strike_blocked) / pitches AS swstr_rate
FROM
  (
    SELECT
      t_players.mlb_name AS name,
      t_batter.batter_id AS batter_id,
      t_batter.plate_appearances AS plate_appearances,
      (t_batter.plate_appearances - t_batter.e_walk - t_batter.e_sac_fly - t_batter.e_sac_bunt - t_batter.e_hit_by_pitch) AS at_bats,
      t_batter.pitches AS pitches,
      t_batter.d_ball AS d_ball,
      t_batter.d_blocked_ball AS d_blocked_ball,
      t_batter.d_called_strike AS d_called_strike,
      t_batter.d_foul AS d_foul,
      t_batter.d_swinging_strike AS d_swinging_strike,
      t_batter.d_swinging_strike_blocked AS d_swinging_strike_blocked,
      t_batter.d_hit_into_play AS d_hit_into_play,
      t_batter.d_hit_into_play_score AS d_hit_into_play_score,
      t_batter.d_foul_tip AS d_foul_tip,
      t_batter.e_field_out AS e_field_out,
      t_batter.e_strikeout AS e_strikeout,
      t_batter.e_single AS e_single,
      t_batter.e_walk AS e_walk,
      t_batter.e_double AS e_double,
      t_batter.e_home_run AS e_home_run,
      t_batter.e_grounded_into_double_play AS e_grounded_into_double_play,
      t_batter.e_force_out AS e_force_out,
      t_batter.e_hit_by_pitch AS e_hit_by_pitch,
      t_batter.e_field_error AS e_field_error,
      t_batter.e_sac_fly AS e_sac_fly,
      t_batter.e_sac_bunt AS e_sac_bunt,
      t_batter.e_triple AS e_triple,
      t_batter.b_ground_ball AS b_ground_ball,
      t_batter.b_line_drive AS b_line_drive,
      t_batter.b_fly_ball AS b_fly_ball,
      t_batter.b_popup AS b_popup
    FROM
      (
        SELECT
          batter_id,
          COUNT(DISTINCT at_bat_key) AS plate_appearances,
          COUNT(*) AS pitches,
          SUM(CASE WHEN description = 'ball' THEN 1 ELSE 0 END) AS d_ball,
          SUM(CASE WHEN description = 'blocked_ball' THEN 1 ELSE 0 END) AS d_blocked_ball,
          SUM(CASE WHEN description = 'called_strike' THEN 1 ELSE 0 END) AS d_called_strike,
          SUM(CASE WHEN description = 'foul' THEN 1 ELSE 0 END) AS d_foul,
          SUM(CASE WHEN description = 'swinging_strike' THEN 1 ELSE 0 END) AS d_swinging_strike,
          SUM(CASE WHEN description = 'swinging_strike_blocked' THEN 1 ELSE 0 END) AS d_swinging_strike_blocked,
          SUM(CASE WHEN description = 'hit_into_play' THEN 1 ELSE 0 END) AS d_hit_into_play,
          SUM(CASE WHEN description = 'hit_into_play_score' THEN 1 ELSE 0 END) AS d_hit_into_play_score,
          SUM(CASE WHEN description = 'foul_tip' THEN 1 ELSE 0 END) AS d_foul_tip,
          SUM(CASE WHEN events = 'field_out' THEN 1 ELSE 0 END) AS e_field_out,
          SUM(CASE WHEN events = 'strikeout' THEN 1 ELSE 0 END) AS e_strikeout,
          SUM(CASE WHEN events = 'single' THEN 1 ELSE 0 END) AS e_single,
          SUM(CASE WHEN events = 'walk' THEN 1 ELSE 0 END) AS e_walk,
          SUM(CASE WHEN events = 'double' THEN 1 ELSE 0 END) AS e_double,
          SUM(CASE WHEN events = 'home_run' THEN 1 ELSE 0 END) AS e_home_run,
          SUM(CASE WHEN events = 'grounded_into_double_play' THEN 1 ELSE 0 END) AS e_grounded_into_double_play,
          SUM(CASE WHEN events = 'force_out' THEN 1 ELSE 0 END) AS e_force_out,
          SUM(CASE WHEN events = 'hit_by_pitch' THEN 1 ELSE 0 END) AS e_hit_by_pitch,
          SUM(CASE WHEN events = 'field_error' THEN 1 ELSE 0 END) AS e_field_error,
          SUM(CASE WHEN events = 'sac_fly' THEN 1 ELSE 0 END) AS e_sac_fly,
          SUM(CASE WHEN events = 'sac_bunt' THEN 1 ELSE 0 END) AS e_sac_bunt,
          SUM(CASE WHEN events = 'triple' THEN 1 ELSE 0 END) AS e_triple,
          SUM(CASE WHEN bb_type = 'ground_ball' THEN 1 ELSE 0 END) AS b_ground_ball,
          SUM(CASE WHEN bb_type = 'line_drive' THEN 1 ELSE 0 END) AS b_line_drive,
          SUM(CASE WHEN bb_type = 'fly_ball' THEN 1 ELSE 0 END) AS b_fly_ball,
          SUM(CASE WHEN bb_type = 'popup' THEN 1 ELSE 0 END) AS b_popup
        FROM
          (
            SELECT
              batter AS batter_id,
              CONCAT(game_pk, at_bat_number) AS at_bat_key,
              pitch_number,
              MAX(description) AS description,
              MAX(events) AS events,
              MAX(bb_type) AS bb_type
            FROM
              `mlbdb`.`statcast`
            WHERE
              game_year = 2018
                AND game_type = 'R'
            GROUP BY 1, 2, 3
          ) t_pitches
        GROUP BY 1
      ) t_batter
        LEFT OUTER JOIN
      (
        SELECT
          mlb_id,
          mlb_name
        FROM
          `mlbdb`.`players`
      ) AS t_players
        ON (t_batter.batter_id = t_players.mlb_id)

  ) t_totals
ORDER BY plate_appearances DESC
LIMIT 500
