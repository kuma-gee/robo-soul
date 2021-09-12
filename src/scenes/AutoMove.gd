extends VisibilityNotifier2D

signal finished()

export var direction := Vector2.RIGHT

export var robot_path: NodePath
onready var robot: Robot = get_node(robot_path)

func _ready():
	robot.set_auto_move(direction)
	connect("screen_entered", self, "_entered")
	
func _entered() -> void:
	robot.set_auto_move(Vector2.ZERO)
	emit_signal("finished")
	queue_free()
