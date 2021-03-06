extends Node

export var use_transition := true

onready var scene_data := $SceneData
onready var transition := $TransitionLayer/Transition

var _data = {}
var next_scene := ""

# TODO: restart scene with transition

func change_scene(scene_name: String = "", type := SceneData.Type.FORWARD) -> void:
	var scene = scene_data.find_scene(scene_name, type)
	if scene != "":
		if use_transition:
			next_scene = scene
			_leave_scene_transition()
		else:
			get_tree().change_scene(scene)

func _leave_scene_transition() -> void:
	transition.show()
	transition.reverse = true
	transition.start()

func _enter_scene_transition() -> void:
	transition.reverse = false
	transition.start()

func _is_enter_transition() -> bool:
	return not transition.reverse

func _on_Transition_finished():
	# Finished enter transition
	if _is_enter_transition():
		transition.hide()

	# Finished leave transition
	if transition.reverse and next_scene != "":
		get_tree().change_scene(next_scene)
		next_scene = ""
		_enter_scene_transition()


func save_data(data) -> void:
	var scene_name = scene_data.current_scene()
	_data[scene_name] = data


func load_data():
	var scene_name = scene_data.current_scene()
	if not _data.has(scene_name): return null
	return _data[scene_name]
