SELECT
  t_event.*,
  t_player.mlb_name AS pitcher_name
FROM
  (
    SELECT
      event_id,
      MAX(pitcher) AS pitcher_id,
      MAX(p_throws) AS pitcher_hand,
      MAX(stand) AS batter_hand,
      MAX(balls) AS balls,
      MAX(strikes) AS strikes,
      CONCAT(CAST(MAX(balls) AS STRING), '-', CAST(MAX(strikes) AS STRING)) AS count,
      MAX(pitch_type) AS pitch_type,
      MAX(description) AS description,
      MAX(events) AS events,
      MAX(estimated_woba_using_speedangle) AS estimated_woba_using_speedangle,
      MAX(woba_value) AS woba_value,
      MAX(woba_denom) AS woba_denom
    FROM
      `ad-fantasy-baseball.core.statcast_extended`
    WHERE
      game_year >= {min_year}
        AND description NOT IN (
          'foul_bunt',
          'hit_by_pitch',
          'intent_ball',
          'missed_bunt',
          'pitchout',
          'bunt_foul_tip',
          'swinging_pitchout',
          'foul_pitchout',
          'pitchout_hit_into_play',
          'pitchout_hit_into_play_score'
        )
    GROUP BY 1
  ) t_event
    LEFT OUTER JOIN
  (
    SELECT
      mlb_id,
      mlb_name
    FROM
      `ad-fantasy-baseball.core.players`
  ) t_player
    ON (t_event.pitcher_id = t_player.mlb_id)