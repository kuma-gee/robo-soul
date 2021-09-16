class_name RelativeSound extends AudioStreamPlayer

export var max_db := 0
export var min_db := -20

func play_relative(percentage: float) -> void:
	play()

func set_relative_volume(percentage: float) -> void:
	var db_size = max_db - min_db
	volume_db = min(min_db + (db_size * percentage), max_db)
