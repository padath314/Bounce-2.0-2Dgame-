extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "ball"):
		body.set_mass(2)		
		queue_free()
