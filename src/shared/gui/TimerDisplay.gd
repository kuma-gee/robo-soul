extends Timer

export var container_path: NodePath
onready var container := get_node(container_path)

export var label_path: NodePath
onready var label := get_node(label_path)

func _ready():
	container.hide()
	connect("timeout", self, "_on_timeout")

func _process(delta):
	if is_stopped(): return
	
	var time = int(ceil(time_left))
	label.text = str(time)

func start(time: float = -1):
	container.show()
	.start(time)

func stop():
	container.hide()
	.stop()

func _on_timeout():
	label.text = "0"
