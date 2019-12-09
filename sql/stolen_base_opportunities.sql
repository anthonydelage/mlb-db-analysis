SELECT
  t_players.fangraphs_id AS player_id,
  t_players.mlb_name AS player_name,
  COUNT(DISTINCT CONCAT(t_base.game_pk, CAST(t_base.inning AS STRING), CAST(t_base.lead_base AS STRING))) AS opportunities,
  SUM(t_base.at_bats) AS at_bat_opportunities
FROM
  (
    SELECT
      game_pk,
      inning,
      COALESCE(on_2b, on_1b) AS lead_runner_id,
      (CASE WHEN on_2b IS NOT NULL THEN 2 ELSE 1 END) AS lead_base,
      COUNT(DISTINCT at_bat_number) AS at_bats
    FROM
      (
        SELECT
          *,
          MAX(max_pitch) OVER (PARTITION BY game_pk, at_bat_number) AS max_ab_pitch
        FROM
          (
            SELECT
              game_pk,
              at_bat_number,
              on_1b,
              on_2b,
              MAX(pitch_number) AS max_pitch,
              MIN(pitch_number) AS min_pitch,
              MAX(inning) AS inning
            FROM
              `ad-fantasy-baseball.core.statcast`
            WHERE
              game_year = 2019
                AND (
                  (on_1b IS NOT NULL AND on_2b IS NULL)
                  OR (on_2b IS NOT NULL AND on_3b IS NULL)
                )
            GROUP BY 1, 2, 3, 4  
          )
      )
    WHERE
      max_pitch > min_pitch
        OR max_ab_pitch > min_pitch
    GROUP BY 1, 2, 3, 4
  ) t_base
    LEFT OUTER JOIN
  (
    SELECT
      mlb_id,
      mlb_name,
      fg_id AS fangraphs_id
    FROM
      `ad-fantasy-baseball.core.players`
    GROUP BY 1, 2, 3
  ) t_players
    ON (t_base.lead_runner_id = t_players.mlb_id)
GROUP BY 1, 2