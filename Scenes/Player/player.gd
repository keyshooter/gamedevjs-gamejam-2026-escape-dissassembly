# the playable character
extends CharacterBody2D

@export var move_speed: float = 100.0
@export var acceleration: float = 50.0
@export var braking: float = 20.0
@export var gravity: float = 500.0
@export var jump_force: float = 200.0

@export var fall_anim_trigger: float = 1.0

@export var health: int = 3

var move_input: float = 0
var player_hurt_state: bool = false
var on_ground = true

var threadmill_velocity: float = 0.0

@onready var sprite: Sprite2D = $Sprite
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Use move input
	move_input = Input.get_axis("move_left", "move_right")
	
	# Movement
	if move_input != 0:
		velocity.x = lerp(velocity.x, move_input * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x , 0.0, braking * delta)
	
	# Jump
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	velocity.x += threadmill_velocity 
	
	move_and_slide()

func take_damage(amount: int):
	health -= amount
	_damage_flash()
	
	if health <= 0:
		game_over()
		
func _damage_flash():
	sprite.modulate = Color.RED
	player_hurt_state = true
	anim_player.play("hurt")
	await get_tree().create_timer(0.25).timeout
	player_hurt_state = false
	sprite.modulate = Color.WHITE

func _process(_delta: float) -> void:
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0
		
	if global_position.y > 200:
		game_over()
		
	_manage_animation()

func game_over() -> void:
	get_tree().reload_current_scene.call_deferred()

func _manage_animation() -> void:
	if player_hurt_state:
		return
	
	if not is_on_floor():
		on_ground = false
		if velocity.y < fall_anim_trigger:
			anim_player.play("jump")
		else:
			anim_player.play("fall")
	else:
		if not on_ground:
			anim_player.play("landed")
			await get_tree().create_timer(0.1).timeout
			on_ground = true
		elif move_input != 0:
			anim_player.play("move")
		else:
			anim_player.play("idle")
		
