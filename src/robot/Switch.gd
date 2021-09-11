extends Area2D

export var laser_path: NodePath
onready var laser: Node2D = get_node(laser_path)

onready var input := $PlayerInput
onready var sprite := $Sprite
onready var machine := $SoulessMachine

func _process(delta):
	if not machine.is_fully_online(): return
	
	if input.is_pressed("move_right"):
		enable()
	elif input.is_pressed("move_left"):
		disable()

func enable() -> void:
	sprite.frame = 1
	laser.hide()
	
func disable() -> void:
	sprite.frame = 0
	laser.show()
