# represents a pressure plate, if the player is under it, it will die
extends Node2D

@onready var dead_zone = $DeadZone
@onready var anim = $AnimationPlayer

# timer for when the dead zone should be active
const TIME_ACTIVATE_DEAD_ZONE: float = 2.76

# maximum time before resetting the counter
const TIME_RESET: float = 3.0

# how much time has passed
var time_passed: float = 0.0

# player under the area
var entered_body: Node2D = null

# we want to start playing the animation
func _ready() -> void:
	anim.play("pressing")

func _process(delta: float) -> void:
	time_passed += delta
	
	# if there is a body under the press
	if entered_body:
		# check if is between the "death time"
		if time_passed >= TIME_ACTIVATE_DEAD_ZONE and time_passed <= TIME_RESET:
			# if it is, kill the player
			entered_body.game_over()
	
	# once the timer has reach 3 or more seconds, reset the timer
	if (time_passed >= TIME_RESET):
		time_passed = 0
		anim.play("pressing")

# if the player entered, we want to store that
func _on_dead_zone_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	entered_body = body 

# if the player leaves, we no longer need the referece
func _on_dead_zone_body_exited(_body: Node2D) -> void:
	entered_body = null
