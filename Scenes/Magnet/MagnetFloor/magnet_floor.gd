extends Node2D

var player_reference: Node2D = null
@export var magnetic_force: float = 5000

func _physics_process(delta: float) -> void:
	if not player_reference:
		return
	
	if not player_reference.is_confused:
		return
		
	var direction = (position - player_reference.position).normalized()
	player_reference.velocity = direction * magnetic_force * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and "is_confused" in body:
		player_reference = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if player_reference == body:
		player_reference = null
