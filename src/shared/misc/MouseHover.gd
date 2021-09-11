class_name MouseHover extends Component

signal mouse_pressed(pos)
signal mouse_move(pos)
signal mouse_released(pos)

export var enabled = false setget _set_enabled

var hover := false
var pressed := false

func _ready():
	get_component_node().connect("mouse_entered", self, "_on_mouse_enter")
	get_component_node().connect("mouse_exited", self, "_on_mouse_exit")
	
func _on_mouse_enter():
	hover = true
	_update_cursor()

func _on_mouse_exit():
	hover = false
	_update_cursor()

func _set_enabled(value: bool) -> void:
	enabled = value
	_update_cursor()

func _update_cursor():
	var cursor = Input.CURSOR_ARROW
	if enabled and (hover or pressed):
		cursor = Input.CURSOR_MOVE
	Input.set_default_cursor_shape(cursor)

func get_component_node() -> CollisionObject2D:
	return node as CollisionObject2D

func _unhandled_input(event):
	if not enabled: return
	
	if event is InputEventMouseMotion and pressed:
		emit_signal("mouse_move", event.global_position)
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			if hover and not pressed:
				pressed = true
				emit_signal("mouse_pressed", event.global_position)
		elif pressed:
			emit_signal("mouse_released", event.global_position)
			pressed = false
			_update_cursor()
