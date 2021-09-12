extends StaticBody2D

export var line_path: NodePath
onready var line: Line2D = get_node(line_path)

onready var collision := $CollisionShape2D

func enable(enabled := true) -> void:
	collision.disabled = not enabled

func update() -> void:
	var points = line.points
	if points.size() < 2: return
	
	var first = points[0]
	var last = points[points.size() - 1]
	
	var center = first + (last / 2)
	position = center
	
	var shape = collision.shape as RectangleShape2D
	shape.extents = Vector2(center.length(), line.width)
