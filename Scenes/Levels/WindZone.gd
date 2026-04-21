extends Area2D
class_name WindZone
## WindZone.gd
## Attach to an Area2D node. Any CharacterBody2D or RigidBody2D inside
## the area will have a horizontal wind force applied each frame.
## The player can still move and fight against the wind normally.
##
## Scene setup:
##   Area2D  (this script)
##   └── CollisionShape2D  (whatever shape you want)

## Wind force in pixels/second for CharacterBody2D.
## Also used as the force magnitude for RigidBody2D (in Newtons).
## Positive = right, negative = left.
@export var wind_force: float = 100.0

## How smoothly the wind force is applied to CharacterBody2D (0 = instant, 1 = never).
## Has no effect on RigidBody2D — force is applied directly each frame.
@export var smoothing: float = 0.1

# Bodies currently inside the zone
var _bodies: Array = []


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _physics_process(_delta: float) -> void:
	for body in _bodies:
		if not is_instance_valid(body):
			continue

		if body is CharacterBody2D:
			# Lerp velocity toward current + wind_force so player can fight it
			body.velocity.x = lerpf(body.velocity.x, body.velocity.x + wind_force, 1.0 - smoothing)

		elif body is RigidBody2D:
			# Apply a continuous force — RigidBody2D handles its own physics
			body.apply_force(Vector2(wind_force, 0.0))


func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D or body is RigidBody2D:
		_bodies.append(body)


func _on_body_exited(body: Node) -> void:
	_bodies.erase(body)
