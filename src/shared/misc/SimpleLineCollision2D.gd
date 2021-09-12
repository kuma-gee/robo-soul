class_name SimpleLineCollision2D extends Component

export var width_multiplier := 1.0

export var line_path: NodePath
onready var line: Line2D = get_node(line_path)

func get_collision_object() -> CollisionObject2D:
	return node as CollisionObject2D

func get_collision_shape() -> CollisionShape2D:
	return get_collision_object().get_node("CollisionShape2D") as CollisionShape2D

func enable(enabled := true) -> void:
	get_collision_shape().disabled = not enabled

func update() -> void:
	var points = line.points
	if points.size() < 2: return
	
	var first = points[0]
	var last = points[points.size() - 1]
	
	var center = first + (last / 2)
	get_collision_object().position = center
	
	var shape = get_collision_shape().shape as RectangleShape2D
	shape.extents = Vector2(center.length(), line.width * width_multiplier)
