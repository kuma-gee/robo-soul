class_name SimpleMove2D extends Node

export var body_path: NodePath
onready var body: KinematicBody2D = get_node(body_path) if body_path else owner

export var speed := 300

var motion := Vector2.ZERO

func _physics_process(_delta):
	var _x = body.move_and_slide(motion * speed)
