extends Node

var version = "dev" setget _set_version
var _normal_run := false

func _ready():
	var main: String = ProjectSettings.get_setting("application/run/main_scene")
	var current_name = get_tree().current_scene.name + ".tscn"
	_normal_run = main.ends_with(current_name)

func _set_version(v: String) -> void:
	if v == "": return
	version = v

func is_prod() -> bool:
	return version != "dev"

func is_web() -> bool:
	return OS.get_name() == "HTML5"

func is_normal_run() -> bool:
	return _normal_run
