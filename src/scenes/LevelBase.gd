extends Node2D


func _on_TileMap_soul_exited():
	GUI.open_menu(GUI.GameOver, true)
