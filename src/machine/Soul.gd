class_name Soul extends KinematicBody2D

enum ColorType {
	RED,
	GREEN,
	YELLOW,
	BLUE,
	ALL,
}

onready var bounce := $Bounce2D
onready var zero_vel_timer := $ZeroVelocityTimer
onready var timer := $Timer
onready var sound := $Bounce2D/WallImpactSound

export(ColorType) var _color: int = ColorType.RED

func _ready():
	update_color()

func update_color(c: int = _color) -> void:
	_color = c
	var color_value = get_color(c)
	$Sprite.modulate = color_value
	$Particles2D.process_material.set("color", color_value)
	
	collision_mask = 0
	set_collision_mask_bit(0, true)
	set_collision_mask_bit(get_color_layer_bit(c), true)

func apply_initial_velocity(vel: Vector2) -> void:
	bounce.set_initial_velocity(vel)


func _process(delta):
	if bounce.velocity.length() < 0.5 and zero_vel_timer.is_stopped() and timer.is_stopped():
		zero_vel_timer.start()
	elif bounce.velocity.length() >= 0.5 and not zero_vel_timer.is_stopped():
		zero_vel_timer.stop()


func _on_Area2D_area_entered(body):
	if not body.has_method("is_online") or body.is_online(): return
	
	if body.has_method("get_accepting_color"):
		var color = body.get_accepting_color()
		if color == ColorType.ALL or color == _color:
			body.online = true
			_free()

func _free() -> void:
	bounce.velocity = Vector2.ZERO
	if sound.playing:
		hide()
		bounce.impact_sound = null
		sound.connect("finished", self, "queue_free")
	else:
		queue_free()

static func get_color(c: int) -> Color:
	match c:
		ColorType.RED: return Color("#e9895e")
		ColorType.GREEN: return Color("#73cd4b")
		ColorType.BLUE: return Color("#1ea7e1")
		ColorType.YELLOW: return Color("#ffcc00")
	
	return Color.white

static func get_color_layer_bit(c: int) -> int:
	match c:
		ColorType.RED: return 8
		ColorType.GREEN: return 9
		ColorType.YELLOW: return 10
		ColorType.BLUE: return 11
	
	return 1


func _on_ColorSwitchDetector_area_exited(area):
	update_color(area.color)


func _on_Timer_timeout():
	GUI.open_menu(GUI.GameOver, true)
