extends Node2D

onready var door_anim := $Door/AnimationPlayer
onready var bgm := $BGM

func _ready():
	bgm.play()

func _on_TileMap_soul_exited():
	GUI.open_menu(GUI.GameOver, true)


func _on_CloseDoorTrigger_body_exited(body):
	door_anim.play("Close")

func _unhandled_input(event):
	if event.is_action_pressed("reload_scene"):
		get_tree().reload_current_scene()
