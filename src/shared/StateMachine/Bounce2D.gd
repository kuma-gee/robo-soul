class_name Bounce2D extends Gravity2D

export var max_friction := 1.5

var velocity := Vector2.ZERO

func get_body() -> KinematicBody2D:
	return node as KinematicBody2D

func _physics_process(delta):
	var deaccell = max_friction * velocity.length()
	velocity = velocity.move_toward(Vector2.ZERO, deaccell * delta)
	velocity += Vector2.DOWN * delta * 10
	
	var collision = get_body().move_and_collide(velocity)
	if collision:
		velocity = velocity.bounce(collision.normal)
