extends VisibilityNotifier2D

signal gameover

onready var timer := $Timer

var velocity := Vector2.ZERO

func _on_GameOverNotifier_screen_exited():
	pass # Replace with function body.
