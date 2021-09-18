extends Light2D

export var light_path: NodePath
onready var light: Light2D = get_node(light_path)

func _process(delta):
	energy = light.energy
