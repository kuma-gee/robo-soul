class_name FaceMotion extends Node

export var body_path: NodePath
onready var body: Node2D = get_node(body_path) if body_path else owner

export var body_direction := Vector2.DOWN

var motion := Vector2.ZERO

func _process(_delta):
	if motion.length() > 0.01:
		var angle = int(rad2deg(body_direction.angle_to(motion)))
		body.rotation_degrees = angle
