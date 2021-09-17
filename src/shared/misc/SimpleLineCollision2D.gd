class_name SimpleLineCollision2D extends Component

export var width_multiplier := 1.0

export var line_path: NodePath
onready var line: Line2D = get_node(line_path)

var collision: CollisionShape2D

func _ready():
	collision = CollisionShape2D.new()
	get_collision_object().add_child(collision)
	collision.shape = RectangleShape2D.new()

func get_collision_object() -> CollisionObject2D:
	return node as CollisionObject2D

func enable(enabled := true) -> void:
	collision.disabled = not enabled

func update() -> void:
	var points = line.points
	if points.size() < 2: return
	
	var first = points[0]
	var last = points[points.size() - 1]
	
	var center = first + (last / 2)
	get_collision_object().position = center
	
	var shape = collision.shape as RectangleShape2D
	shape.extents = Vector2(center.length(), line.width * width_multiplier)
