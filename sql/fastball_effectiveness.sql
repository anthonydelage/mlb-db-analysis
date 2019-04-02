SELECT
  t_events.pitcher_id AS pitcher_id,
  t_events.batter_id AS batter_id,
  t_pitcher.pitcher_name AS pitcher_name,
  t_batter.batter_name AS batter_name,
  t_events.pitcher_hand AS pitcher_hand,
  t_events.batter_hand AS batter_hand,
  t_events.same_hand AS same_hand,
  t_events.release_speed AS release_speed,
  t_events.release_spin_rate AS release_spin_rate,
  t_events.horizontal_movemment AS horizontal_movemment,
  t_events.vertical_movement AS vertical_movement,
  t_events.horizontal_location AS horizontal_location,
  t_events.vertical_location AS vertical_location,
  t_events.outcome AS outcome
FROM
  (
    SELECT
      pitcher AS pitcher_id,
      batter AS batter_id,
      p_throws AS pitcher_hand,
      stand AS batter_hand,
      (CASE WHEN p_throws = stand THEN 1 ELSE 0 END) AS same_hand,
      release_speed,
      release_spin_rate,
      pfx_x AS horizontal_movemment,
      pfx_z AS vertical_movement,
      plate_x AS horizontal_location,
      plate_z AS vertical_location,
      description AS outcome
    FROM
      `ad-fantasy-baseball.core.statcast`
    WHERE
      game_type = 'R'
        AND game_year >= 2016
        AND pitch_type = 'FF'
  ) t_events
    LEFT OUTER JOIN
  (
    SELECT
      mlb_id AS pitcher_id,
      MAX(mlb_name) AS pitcher_name
    FROM
      `ad-fantasy-baseball.core.players`
    GROUP BY 1
  ) t_pitcher
    ON (t_events.pitcher_id = t_pitcher.pitcher_id)
    LEFT OUTER JOIN
  (
    SELECT
      mlb_id AS batter_id,
      MAX(mlb_name) AS batter_name
    FROM
      `ad-fantasy-baseball.core.players`
    GROUP BY 1
  ) t_batter
    ON (t_events.batter_id = t_batter.batter_id)