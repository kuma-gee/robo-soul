extends Node2D

onready var door_anim := $Door/AnimationPlayer

func _on_TileMap_soul_exited():
	GUI.open_menu(GUI.GameOver, true)


func _on_CloseDoorTrigger_body_exited(body):
	door_anim.play("Close")
