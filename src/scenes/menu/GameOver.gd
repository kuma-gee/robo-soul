extends PausedMenu

onready var sound := $GameOverSound

func _ready():
	sound.play()

func _unhandled_input(event):
	if event.is_action_pressed("reload_scene"):
		get_tree().reload_current_scene()
		GUI.open_menu(GUI.InGame, true)
