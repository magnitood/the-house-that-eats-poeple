extends Control

@onready var start: Button = $VBoxContainer/start
@onready var quit: Button = $VBoxContainer/quit

const START = preload("res://rooms/start.tscn")

func _on_start_pressed() -> void:
	GameManager.level_start()
	get_tree().change_scene_to_packed(START)



func _on_quit_pressed() -> void:
	get_tree().quit()
