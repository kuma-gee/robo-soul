class_name Robot extends KinematicBody2D

export var flick_force := 1.0
export var online := false setget _set_online

onready var input := $PlayerInput
onready var move := $SimpleMove2D
onready var gravity := $Gravity2D
onready var turn := $TurnMotion2D
onready var anim := $AnimationPlayer
onready var flick := $FlickArea/MouseHover

const SOUL = preload("res://src/robot/Soul.tscn")

var _transitioning := false
var _auto_move := Vector2.ZERO

func _set_online(value: bool) -> void:
	_transitioning = true
	if value:
		$AnimationPlayer.play("Online")
	else:
		$AnimationPlayer.play("Offline")

func is_online() -> bool:
	return online or _transitioning

func _physics_process(delta):
	var motion = Vector2.ZERO
	
	if online and not _transitioning:
		motion = _get_motion()
		if motion.length() > 0.01:
			anim.play("Move")
		else:
			anim.stop()
	
	turn.motion = motion
	motion = gravity.apply_gravity(motion, delta)
	move.motion = motion

func _get_motion() -> Vector2:
	if _auto_move.length() != 0:
		return _auto_move
	
	return Vector2(
		input.get_action_strength("move_right") - input.get_action_strength("move_left"),
		0
	)

func set_auto_move(dir: Vector2) -> void:
	print("Set automove " + str(dir))
	_auto_move = dir

func _on_FlickArea_flicked(dir: Vector2):
	var soul = SOUL.instance()
	get_tree().current_scene.add_child(soul)
	soul.global_position = global_position
	soul.apply_initial_velocity(dir * flick_force)
	self.online = false

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Online":
		online = true
		flick.enabled = true
		_transitioning = false
	elif anim_name == "Offline":
		online = false
		flick.enabled = false
		_transitioning = false
