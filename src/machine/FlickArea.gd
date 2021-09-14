extends Area2D

signal flicked(dir)

export var max_length := 100
export var min_length := 30

onready var line := $Line
onready var mouse := $MouseHover
onready var timer := $FireRateTimer

var can_fire := true
var press_pos

func set_enabled(value: bool) -> void:
	mouse.enabled = value

func _on_MouseHover_mouse_pressed(pos: Vector2):
	if not can_fire: return
	
	press_pos = _to_local_pos(pos)
	line.add_point(_to_local_pos(global_position))
	can_fire = false


func _on_MouseHover_mouse_released(pos: Vector2):
	line.clear_points()
	
	if not press_pos: return

	var dir: Vector2 = _get_arrow_dir(pos)
	if dir.length() >= min_length:
		dir = dir.rotated(global_rotation)
		var length_ratio = dir.length() / max_length
		var normalized = dir.normalized() * length_ratio
		emit_signal("flicked", normalized)
	
	press_pos = null
	timer.start()

func _on_MouseHover_mouse_move(pos: Vector2):
	if not press_pos: return
	
	var arrow_tip = _to_local_pos(global_position) + _get_arrow_dir(pos)
	
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
	var local: Vector2 = global_pos - global_position
	
	local = local.rotated(-global_rotation)
	
	return local

func set_color(color: Color) -> void:
	line.default_color = color


func _on_FireRateTimer_timeout():
	can_fire = true
