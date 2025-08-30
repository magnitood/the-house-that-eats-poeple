extends Control

const ROOM_1 = preload("res://rooms/room_1.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_packed(ROOM_1)
