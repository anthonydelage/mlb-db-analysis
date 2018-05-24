SELECT
	player_name,
	game_year,
	pitch_type,
	AVG(release_speed) AS avg_velo,
	COUNT(*) AS pitches
FROM
	`mlbdb`.`statcast`
GROUP BY 1, 2, 3
ORDER BY 4 DESC
LIMIT 100
