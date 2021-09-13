class_name Bounce2D extends Component

export var max_friction := 100

var velocity := Vector2.ZERO
var max_gravity := Vector2.DOWN * 9

onready var gravity := $Gravity2D

func get_body() -> KinematicBody2D:
	return node as KinematicBody2D

func set_initial_velocity(vel: Vector2):
	velocity = vel

func _physics_process(delta):
	
	velocity = velocity.move_toward(Vector2.ZERO, 5 * delta)
	velocity = velocity.move_toward(velocity + max_gravity, 30 * delta)

	var collision = get_body().move_and_collide(velocity)
	if collision:
		velocity = velocity.bounce(collision.normal)
