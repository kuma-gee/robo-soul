class_name TurnMotion2D extends Component

var motion: Vector2
var orig_scale: float

func _ready():
	orig_scale = node.scale.x

func _physics_process(_delta):
	if motion.length() > 0.1:
		node.scale.x = orig_scale if motion.x >= 0 else -orig_scale
