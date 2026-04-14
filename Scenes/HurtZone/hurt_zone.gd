# if the player enters here, it will be hurt
extends Area2D

# the amount of damage it will induce to the player
@export var damage_dealt: int = 1

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	body.take_damage(damage_dealt)
