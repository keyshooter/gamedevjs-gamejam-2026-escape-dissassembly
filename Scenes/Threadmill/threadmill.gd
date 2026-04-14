# represents a threadmill block, it will move whatever is mark as Pushable
extends Area2D

@export var impulse: float = 5.0
@export var move_speed: float = 100.0

var elements_to_push: Array[Node2D] = []

func _physics_process(delta: float) -> void:
	for body in elements_to_push:
		body.velocity.x = lerp(body.velocity.x, 1 * move_speed, impulse * delta)


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Pushable"):
		return
	
	elements_to_push.append(body)


func _on_body_exited(body: Node2D) -> void:
	elements_to_push.erase(body)
