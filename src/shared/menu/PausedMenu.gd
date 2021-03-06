extends GUIMenu

class_name PausedMenu

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	_pause()
	
#	connect("tree_exiting", self, "_resume")


func _exit_tree():
	_resume()


func _pause():
	if is_inside_tree():
		get_tree().paused = true


func _resume():
	if is_inside_tree():
		get_tree().paused = false
