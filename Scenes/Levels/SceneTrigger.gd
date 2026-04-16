extends Area2D


## Path to the scene file to load, e.g. "res://scenes/Level2.tscn"
@export_file("*.tscn") var next_scene: String = ""

## Optional: only trigger for nodes in this group (e.g. "player")
@export var trigger_group: String = "player"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if trigger_group == "" or body.is_in_group(trigger_group):
		if next_scene != "":
			SceneTransition.change_scene(next_scene)
		else:
			push_warning("SceneTrigger: no next_scene set on " + name)
