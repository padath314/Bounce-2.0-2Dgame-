extends Node

func _on_replay_pressed() -> void:
	get_tree().reload_current_scene()
