extends Node2D

@export var target_level : PackedScene

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if(body.name == "ball"):
		print("ball entered")
		get_tree().change_scene_to_packed(target_level)
