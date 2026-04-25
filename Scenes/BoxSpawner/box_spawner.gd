extends Node2D

@export var seconds_to_spawn: float = 5.0
@export var spawn_location: Marker2D
@export var element_to_spawn: PackedScene

var seconds_passed: float = 0.0
var can_spawn: bool = false

func _ready() -> void:
	can_spawn = spawn_location != null and element_to_spawn != null

func _process(delta: float) -> void:
	if not can_spawn:
		return

	seconds_passed += delta

	if seconds_passed >= seconds_to_spawn:
		seconds_passed = 0.0
		var element = element_to_spawn.instantiate()
		get_tree().current_scene.add_child(element)
		element.global_position = spawn_location.global_position
