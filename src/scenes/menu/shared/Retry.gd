extends Button


func _on_Retry_pressed():
	get_tree().reload_current_scene()
	GUI.open_menu(GUI.InGame, true)
