extends Area2D

export var laser_path: NodePath
onready var laser: Laser = get_node(laser_path)

onready var input := $PlayerInput
onready var sprite := $Sprite
onready var machine := $SoulessMachine

func _ready():
	_update_laser()
	laser.change_color(machine.accept_color)

func _process(_delta):
	if not machine.is_fully_online(): return
	
	if input.is_just_pressed("move_right"):
		enable()
	elif input.is_just_pressed("move_left"):
		disable()

func enable() -> void:
	sprite.frame = 1
	_update_laser()
	
func disable() -> void:
	sprite.frame = 0
	_update_laser()

func is_enabled() -> bool:
	return sprite.frame == 1

func _update_laser() -> void:
	if laser.is_casting == is_enabled(): return
	laser.is_casting = is_enabled()
