extends Node2D

@onready var ActionsTaken = get_node("%ActionsTaken") as Label


func _ready() -> void:
	set_actions_text()

func set_actions_text():
	var scene1 = CurrentLoop.get_scene_actions_as_string(1)
	var scene2 = CurrentLoop.get_scene_actions_as_string(2)

	ActionsTaken.text = "%s\n%s" % [scene1, scene2]

