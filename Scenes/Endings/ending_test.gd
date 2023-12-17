extends Node2D

@onready var ActionsTaken = get_node("%ActionsTaken") as Label


func _ready() -> void:
	set_actions_text()

func set_actions_text():
	var scene1 = CurrentLoop.get_scene_actions_as_string(1)
	var scene2 = CurrentLoop.get_scene_actions_as_string(2)

	ActionsTaken.text = "%s\n%s" % [scene1, scene2]

	var scene_2_actions = CurrentLoop.get_scene_actions_ids(2)

	if scene_2_actions == "A":
		get_tree().change_scene_to_file("res://Scenes/DoTimeTravel/do_time_travel.tscn")
	elif scene_2_actions == "B":
		get_tree().change_scene_to_file("res://Scenes/DoTimeTravel/do_time_travel.tscn")
	elif scene_2_actions == "C":
		get_tree().change_scene_to_file("res://Scenes/DoTimeTravel/do_time_travel.tscn")
	elif scene_2_actions == "D":
		get_tree().change_scene_to_file("res://Scenes/Endings/GoodEnding/good_ending.tscn")
	elif scene_2_actions == "E":
		get_tree().change_scene_to_file("res://Scenes/DoTimeTravel/do_time_travel.tscn")

