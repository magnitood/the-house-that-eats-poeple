extends Node2D

var player:CharacterBody2D
var activated = false
var time:float = 0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	print(time)
	if activated:
		time+=delta
	if time>3:
		if absf(player.global_position.x - global_position.x)<500:
			player.take_damage("bomb")
		queue_free()
			

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		activated = true
