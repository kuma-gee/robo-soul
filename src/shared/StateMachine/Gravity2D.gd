class_name Gravity2D extends Component

export var multiplier := 1.0

onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * ProjectSettings.get_setting("physics/2d/default_gravity_vector")

func apply_gravity(vec: Vector2, delta: float) -> Vector2:
	vec += gravity * multiplier * delta
	return vec
