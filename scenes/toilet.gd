extends Area2D


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	body.set_mass(1.0)
