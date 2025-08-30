extends Area2D

func _ready():
	$InteractSprite.visible = false

func _on_body_entered(body):
	if body.is_in_group("player"):
		$InteractSprite.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		$InteractSprite.visible = false
