extends Area2D

signal flicked(dir)

export var max_length := 100
export var min_length := 50

onready var line := $Line
onready var mouse := $MouseHover

var press_pos

func set_enabled(value: bool) -> void:
	mouse.enabled = value

func _on_MouseHover_mouse_pressed(_pos: Vector2):
	press_pos = _to_local_pos(global_position)
	line.add_point(press_pos)


func _on_MouseHover_mouse_released(pos: Vector2):
	line.clear_points()

	var dir: Vector2 = _get_arrow_dir(pos)
	if dir.length() >= min_length:
		emit_signal("flicked", dir)
	
	press_pos = null

func _on_MouseHover_mouse_move(pos: Vector2):
	var arrow_tip = press_pos + _get_arrow_dir(pos)
	
	if line.points.size() < 2:
		line.add_point(arrow_tip)
	else:
		line.set_point_position(1, arrow_tip)

func _get_arrow_dir(global_pos: Vector2) -> Vector2:
	var local = _to_local_pos(global_pos)
	var dir = local.direction_to(press_pos)
	var dist = min(local.distance_to(press_pos), max_length)
	return dir * dist
	
func _to_local_pos(global_pos: Vector2) -> Vector2:
	return global_pos - global_position
