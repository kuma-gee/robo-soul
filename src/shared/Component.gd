class_name Component extends Node

export var node_path: NodePath
onready var node := get_node(node_path) if node_path else owner

