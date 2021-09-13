class_name SoulessMachine extends Area2D

signal online()

export(Soul.ColorType) var accept_color := Soul.ColorType.RED
export var flick_force := 1.0

export var flick_path: NodePath
onready var flick: Node2D = get_node(flick_path) if flick_path else null

export var anim_path: NodePath
onready var anim: AnimationPlayer = get_node(anim_path) if anim_path else null

export var online := false setget _set_online

const SOUL = preload("res://src/machine/Soul.tscn")

var start_online := false
var _transitioning := false

func _ready():
	if anim:
		anim.connect("animation_finished", self, "_on_finished")
	if flick:
		flick.connect("flicked", self, "_on_FlickArea_flicked")
		flick.set_color(Soul.get_color(accept_color))

func _set_online(value: bool) -> void:
	if anim_path:
		_transitioning = true
		if value:
			get_node(anim_path).play("Online")
		else:
			get_node(anim_path).play("Offline")
	else:
		online = value
		emit_signal("online")

func is_online() -> bool:
	return online or _transitioning

func is_fully_online() -> bool:
	return online and not _transitioning

func get_accepting_color() -> int:
	return accept_color

func _on_finished(anim_name: String) -> void:
	if anim_name == "Online":
		online = true
		flick.set_enabled(true)
		_transitioning = false
	elif anim_name == "Offline":
		online = false
		flick.set_enabled(false)
		_transitioning = false
	elif anim_name == "Start" and start_online:
		self.online = true

func _on_FlickArea_flicked(dir: Vector2):
	var soul = SOUL.instance()
	get_tree().current_scene.add_child(soul)
	soul.update_color(accept_color)
	soul.global_position = flick.global_position
	soul.apply_initial_velocity(dir * flick_force)
	self.online = false
