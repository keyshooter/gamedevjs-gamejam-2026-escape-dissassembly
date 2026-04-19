extends Area2D
class_name LowGravityZone
## LowGravityZone.gd
## Attach to an Area2D node. Any CharacterBody2D that enters the area
## will have its gravity scale reduced while inside.
##
## Scene setup:
##   Area2D  (this script)
##   └── CollisionShape2D  (whatever shape you want)

## Gravity scale applied to the player while inside (0.0 = weightless, 1.0 = normal)
@export var gravity_scale: float = 0.2

## The gravity scale to restore when the player leaves
var _previous_gravity: Dictionary = {}


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		# Store whatever gravity scale the body had before entering
		if body.has_meta("gravity_scale"):
			_previous_gravity[body] = body.get_meta("gravity_scale")
		else:
			_previous_gravity[body] = 1.0
		body.set_meta("gravity_scale", gravity_scale)


func _on_body_exited(body: Node) -> void:
	if body is CharacterBody2D:
		# Restore the previous gravity scale
		var restored: float = _previous_gravity.get(body, 1.0)
		body.set_meta("gravity_scale", restored)
		_previous_gravity.erase(body)
