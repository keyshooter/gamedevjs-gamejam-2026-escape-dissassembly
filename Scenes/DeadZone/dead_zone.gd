# if the player enters here is insta-killed
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.game_over()
		return
	
	if body.is_in_group("Box"):
		body.queue_free()
