SELECT
  t_event.*,
  t_player.mlb_name AS batter_name
FROM
  (
    SELECT
      game_year,
      batter AS batter_id,
      SUM(CASE WHEN events IN ('single', 'double', 'triple') THEN 1 END) AS hits_no_hr,
      SUM(CASE WHEN events != 'home_run' THEN 1 END) AS balls_in_play,
      SUM(CASE WHEN events IN ('single', 'double', 'triple')
        AND bb_type != 'popup' THEN 1 END) AS hits_no_popup_no_hr,
      SUM(CASE WHEN events != 'home_run'
        AND bb_type != 'popup' THEN 1 END) AS balls_in_play_no_popup,
      STDDEV_POP(launch_angle) AS stdev_la,
      STDDEV_POP(CASE WHEN bb_type != 'popup' THEN launch_angle END) AS stdev_la_no_popup
    FROM
      `ad-fantasy-baseball.core.statcast`
    WHERE
      type = 'X'
        AND game_year >= {min_year}
    GROUP BY 1, 2
  ) t_event
    INNER JOIN
  (
    SELECT
      mlb_id,
      mlb_name
    FROM
      `ad-fantasy-baseball.core.players`
  ) t_player
    ON (t_event.batter_id = t_player.mlb_id)