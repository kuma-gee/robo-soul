class_name ImpactSound extends AudioStreamPlayer

export var max_db := 0
export var min_db := -20
export var max_velocity := 100
export var min_velocity := 1

# Technical details here: https://youtu.be/MOYiVLEnhrw?t=9991
func impact(velocity: Vector2, normal: Vector2) -> void:
	if velocity.length() <= min_velocity:
		return
	
	var size = abs(velocity.dot(normal))
	var percentage = (velocity.length() / max_velocity) * (size / velocity.length())
	
	var db_size = max_db - min_db
	volume_db = min(min_db + (db_size * percentage), max_db)
	play()
