extends Area2D

var direction: Vector2 = Vector2.LEFT
var speed: float = 150.0

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta * direction

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.confuse_player()
	
	queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
