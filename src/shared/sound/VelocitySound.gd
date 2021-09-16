class_name VelocitySound extends RelativeSound

export var max_velocity := 1

func set_volume(velocity: Vector2) -> void:
	var percentage = velocity.length() / max_velocity
	set_relative_volume(percentage)
