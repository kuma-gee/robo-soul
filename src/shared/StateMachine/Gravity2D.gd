class_name Gravity2D extends Component

export var multiplier := 1.0

onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * ProjectSettings.get_setting("physics/2d/default_gravity_vector")

export var max_terminal_velocity = 10
var y_velocity = 0.0

func get_body() -> KinematicBody2D:
	return node as KinematicBody2D

func apply_gravity(vec: Vector2, delta: float) -> Vector2:
	vec += gravity * multiplier * delta
	return vec

func update_gravity(vec: Vector2) -> Vector2:
	y_velocity = clamp(y_velocity + gravity.y, -max_terminal_velocity, max_terminal_velocity)
	vec.y = y_velocity
	return vec

func reset():
	y_velocity = 0.0
