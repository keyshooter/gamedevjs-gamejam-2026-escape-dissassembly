extends Node2D

@onready var player := AudioStreamPlayer.new()

func _ready() -> void:
	add_child(player)
	player.stream = preload("res://Audio/industrial_zone.mp3")
	player.play()

func change_track(stream: AudioStream) -> void:
	player.stream = stream
	player.play()
