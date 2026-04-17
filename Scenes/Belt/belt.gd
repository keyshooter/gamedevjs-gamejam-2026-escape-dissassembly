extends StaticBody2D

@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	constant_linear_velocity.x = speed
