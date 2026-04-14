extends RigidBody2D

var threadmill_velocity: float = 0.0

func _physics_process(delta: float) -> void:
	linear_velocity.x += threadmill_velocity
	

func game_over() -> void:
	call_deferred("queue_free")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
