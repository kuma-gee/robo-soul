extends StaticBody2D

onready var collision := $CollisionShape2D

func show():
	collision.disabled = false
	.show()
	
func hide():
	collision.disabled = true
	.hide()
