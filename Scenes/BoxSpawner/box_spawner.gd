extends Node2D


@export var seconds_to_spawn: float = 5.0
@export var spawn_location: Marker2D
@export var element_to_spawn: PackedScene

var seconds_passed: float = 0.0
var can_spawn: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_spawn = !!spawn_location and !!element_to_spawn


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	seconds_passed += delta
	
	if can_spawn and seconds_passed >= seconds_to_spawn:
		seconds_passed = 0.0
		var element = element_to_spawn.instantiate()
		element.position = spawn_location.position
		add_child(element)
