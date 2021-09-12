extends CanvasLayer

signal screen_changed(screen)

enum {
	Main,
	Options,
	GeneralOptions,
	AudioOptions,
	ControlOptions,
	InGame,
	GameOver,
	Pause,
	About,
}

const screen_scene_map = {
	Main: preload("res://src/scenes/menu/MainMenu.tscn"),
	Options: preload("res://src/scenes/menu/options/Options.tscn"),
	GeneralOptions: preload("res://src/scenes/menu/options/General.tscn"),
	AudioOptions: preload("res://src/scenes/menu/options/Audio.tscn"),
	ControlOptions: preload("res://src/scenes/menu/options/Controls.tscn"),
	GameOver: preload("res://src/scenes/menu/GameOver.tscn"),
	Pause: preload("res://src/scenes/menu/Pause.tscn"),
	About: preload("res://src/scenes/menu/About.tscn"),
}

onready var stack := $MenuStack
onready var theme := $Theme

var min_menu_size = 1
var current #: GUIMenu

func _ready():
	var _x = stack.connect("removed", self, "_add_current_menu", [false])
	var _y = stack.connect("added", self, "_add_current_menu", [true])
	_update_gui()
	
	if not Env.is_normal_run():
		min_menu_size = 0


func _unhandled_input(event):
	if _current_menu() != Pause and \
		(_current_menu() == InGame or not Env.is_normal_run()) and \
		event.is_action_pressed("pause"):
		
		open_menu(Pause)
	elif event.is_action_pressed("ui_cancel"):
		stack.pop()

func open_menu(menu, clear = false):
	open({"menu": menu}, clear)


func open(data = {}, clear = false):
	if clear:
		stack.clear()
	stack.push(data)


func back_menu():
	if stack.size() <= min_menu_size:
		return
	
	stack.pop()

func _current_menu():
	return stack.current["menu"] if stack.current else null

func _add_current_menu(_value, added: bool):
	var menu = _current_menu()

	if current != null and current.has_method("get_data"):
		var data = current.get_data()
		var current_data = stack.current
		for key in data:
			current_data[key] = data[key]
		stack.replace(current_data)
	
	_remove_all_menus()
	
	if screen_scene_map.has(menu):
		var scene = screen_scene_map[menu]
		current = scene.instance()
		theme.add_child(current)
		if current.has_method("init") and added:
			current.init(stack.current)
	
	emit_signal("screen_changed", menu)
	_update_gui()

func _remove_all_menus():
	for child in theme.get_children():
		theme.remove_child(child)

func _update_gui():
	var filter = Control.MOUSE_FILTER_IGNORE if theme.get_child_count() == 0 else Control.MOUSE_FILTER_STOP
	theme.mouse_filter = filter
