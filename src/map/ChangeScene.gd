extends Node2D

var ignore_inputs := false

func _unhandled_input(event):
	if ignore_inputs:
		get_tree().set_input_as_handled()


func _on_SceneArea2D_entered():
	ignore_inputs = true
