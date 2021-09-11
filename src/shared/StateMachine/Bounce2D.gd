class_name Bounce2D extends Component

export var min_friction := 100

var velocity := Vector2.ZERO

func get_body() -> RigidBody2D:
	return node as RigidBody2D

#func _physics_process(delta):
##	var deaccell = max(pow(velocity.length() / 2, 2), min_friction)
#	velocity = velocity.move_toward(Vector2.ZERO, min_friction * delta)
##	velocity += Vector2.DOWN
#
#	var collision = get_body().move_and_collide(velocity)
#	if collision:
#		velocity = velocity.bounce(collision.normal)
