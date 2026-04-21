extends Node2D

@onready var timer: Timer = $Timer
@export var bullet_timer: float = 0.5
@export var bullet_scene: PackedScene = null
@export var direction: Vector2 = Vector2.LEFT

var can_spawn: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_spawn = !!bullet_scene
	timer.wait_time = bullet_timer
	timer.connect("timeout", shoot_bullet)
	timer.start()

func shoot_bullet() -> void:
	if can_spawn:
		var bullet = bullet_scene.instantiate()
		bullet.direction = direction
		add_child(bullet)
		


func _on_screen_check_screen_entered() -> void:
	can_spawn = !!bullet_scene

func _on_screen_check_screen_exited() -> void:
	can_spawn = false
