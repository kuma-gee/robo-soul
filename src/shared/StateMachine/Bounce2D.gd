class_name Bounce2D extends Component

signal bounced()

export var max_friction := 100

export var impact_sound_path: NodePath
onready var impact_sound: ImpactSound = get_node(impact_sound_path) if impact_sound_path else null

var velocity := Vector2.ZERO
var max_gravity := Vector2.DOWN * 9

onready var gravity := $Gravity2D

func get_body() -> KinematicBody2D:
	return node as KinematicBody2D

func set_initial_velocity(vel: Vector2):
	velocity = vel

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, 5 * delta)
	velocity = velocity.move_toward(velocity + max_gravity, 30 * delta)

	var collision = get_body().move_and_collide(velocity)
	if collision:
		var sound = collision.collider.get_sound() if collision.collider.has_method("get_sound") else impact_sound
		if sound:
			sound.impact(velocity, collision.normal)
		velocity = velocity.bounce(collision.normal)
		emit_signal("bounced")
