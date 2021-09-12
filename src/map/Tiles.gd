extends TileMap

signal soul_exited()

func _on_Area2D_body_entered(body):
	emit_signal("soul_exited")
