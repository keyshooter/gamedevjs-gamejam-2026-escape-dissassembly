extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WavedashSDK.backend_connected.connect(_on_connected)
	WavedashSDK.init({"debug": true})

func _on_connected(_payload):
	print("Playing as: ", WavedashSDK.get_username())
