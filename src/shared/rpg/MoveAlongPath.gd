class_name NavigationPathMove extends Node

export var character_path: NodePath
onready var character: Node2D = get_node(character_path) if character_path else owner

export var speed := 300

var path := PoolVector2Array() setget _set_path

func _set_path(p) -> void:
	print(p)
	path = p
	if path.size() > 0:
		path.remove(0)
		set_process(true)


func _process(delta):
	var walk_distance = speed * delta
	move_along_path(walk_distance)


func move_along_path(distance):
	var last_point = character.position
	while path.size() > 0:
		var distance_between_points = last_point.distance_to(path[0])
		# The position to move to falls between two points.
		if distance <= distance_between_points:
			character.position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			return
		# The position is past the end of the segment.
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)
	# The character reached the end of the path.
	character.position = last_point
	set_process(false)
