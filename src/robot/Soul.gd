extends RigidBody2D

#onready var bounce := $Bounce2D

func apply_initial_velocity(vel: Vector2) -> void:
	apply_central_impulse(vel)


func _on_Area2D_area_entered(body):
	if not body.has_method("is_online") or body.is_online(): return
	
	body.online = true
	queue_free()
