extends Area2D
class_name WindZone
## WindZone.gd
## Attach to an Area2D node. Any CharacterBody2D inside the area
## will have a horizontal wind force added to their velocity each frame.
## The player can still move and fight against the wind normally.
##
## Scene setup:
##   Area2D  (this script)
##   └── CollisionShape2D  (whatever shape you want)

## Wind force in pixels/second. Positive = right, negative = left.
@export var wind_force: float = 100.0

## How smoothly the wind force is applied (0 = instant, 1 = never)
@export var smoothing: float = 0.1

# Bodies currently inside the zone
var _bodies: Array = []


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _physics_process(delta: float) -> void:
	for body in _bodies:
		if is_instance_valid(body) and body is CharacterBody2D:
			body.velocity.x = lerpf(body.velocity.x, body.velocity.x + wind_force, 1.0 - smoothing)


func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		_bodies.append(body)


func _on_body_exited(body: Node) -> void:
	_bodies.erase(body)
