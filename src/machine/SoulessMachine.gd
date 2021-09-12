class_name SoulessMachine extends Area2D

export(Soul.ColorType) var accept_color = Soul.ColorType.RED
export var flick_force := 10

export var flick_path: NodePath
onready var flick: Node2D = get_node(flick_path)

export var anim_path: NodePath
onready var anim: AnimationPlayer = get_node(anim_path)

export var online := false setget _set_online

const SOUL = preload("res://src/machine/Soul.tscn")

var _transitioning := false

func _ready():
	anim.connect("animation_finished", self, "_on_finished")
	flick.connect("flicked", self, "_on_FlickArea_flicked")

func _set_online(value: bool) -> void:
	_transitioning = true
	if value:
		get_node(anim_path).play("Online")
	else:
		get_node(anim_path).play("Offline")

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

func _on_FlickArea_flicked(dir: Vector2):
	var soul = SOUL.instance()
	get_tree().current_scene.add_child(soul)
	soul.color = accept_color
	soul.global_position = flick.global_position
	soul.apply_initial_velocity(dir * flick_force)
	self.online = false
