class_name Robot extends KinematicBody2D

export var online := false setget _set_online

onready var input := $PlayerInput
onready var move := $SimpleMove2D
onready var gravity := $Gravity2D
onready var turn := $TurnMotion2D
onready var anim := $AnimationPlayer
onready var machine := $SoulessMachine

var _auto_move := Vector2.ZERO

func _set_online(value: bool) -> void:
	$SoulessMachine.start_online = value

func _physics_process(delta):
	var motion = Vector2.ZERO
	
	if machine.is_fully_online():
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
	_auto_move = dir
