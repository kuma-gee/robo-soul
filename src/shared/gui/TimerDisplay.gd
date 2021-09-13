extends Timer

export var label_path: NodePath
onready var label := get_node(label_path)

func _ready():
	label.hide()
	connect("timeout", self, "_on_timeout")

func _process(delta):
	if is_stopped(): return
	
	var time = int(ceil(time_left))
	label.text = str(time)

func start(time: float = -1):
	label.show()
	.start(time)

func stop():
	label.hide()
	.stop()

func _on_timeout():
	label.text = "0"
