extends KinematicBody2D

onready var bounce := $Bounce2D

func apply_initial_velocity(vel: Vector2) -> void:
	bounce.velocity = vel


func _on_Area2D_body_entered(body: Node2D):
	if not body.has_method("is_online") or body.is_online(): return
	
	body.online = true
	queue_free()
