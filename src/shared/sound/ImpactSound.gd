class_name ImpactSound extends RelativeSound

export var max_velocity := 100
export var min_velocity := 1

# Technical details here: https://youtu.be/MOYiVLEnhrw?t=9991
func impact(velocity: Vector2, normal: Vector2) -> void:
	if velocity.length() <= min_velocity:
		return
	
	var size = abs(velocity.dot(normal.normalized()))
	var percentage = (velocity.length() / max_velocity) * (size / velocity.length())
	
	print(percentage)
	play_relative(percentage)
