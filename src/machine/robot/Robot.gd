class_name Robot extends KinematicBody2D

export var online := false setget _set_online

onready var input := $PlayerInput
onready var move := $SimpleMove2D
onready var gravity := $Gravity2D
onready var turn := $TurnMotion2D
onready var anim := $AnimationPlayer
onready var machine := $SoulessMachine
onready var flick := $FlickArea
onready var move_sound := $MoveSound

var _auto_move := Vector2.ZERO

func _set_online(value: bool) -> void:
	$SoulessMachine.start_online = value

func _physics_process(delta):
	var motion = Vector2.ZERO
	
	if machine.is_fully_online():
		flick.set_enabled(not _is_auto_moving())
		
		motion = _get_motion()
		if motion.length() > 0.01:
			if not anim.is_playing():
				anim.play("Move")
				move_sound.play()
		else:
			anim.stop()
			move_sound.stop()
	
	turn.motion = motion
	motion = gravity.apply_gravity(motion, delta)
	move.motion = motion

func _get_motion() -> Vector2:
	if _is_auto_moving():
		return _auto_move
	
	return Vector2(
		input.get_action_strength("move_right") - input.get_action_strength("move_left"),
		0
	)

func set_auto_move(dir: Vector2) -> void:
	_auto_move = dir
	
func _is_auto_moving() -> bool:
	return _auto_move.length() != 0
