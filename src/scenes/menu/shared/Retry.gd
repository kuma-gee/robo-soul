extends Button


func _on_Retry_pressed():
	get_tree().reload_current_scene()
	GUI.back_menu()
