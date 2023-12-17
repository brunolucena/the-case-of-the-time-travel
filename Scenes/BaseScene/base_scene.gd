class_name Scene
extends Node2D

@export var level_number: int

var max_actions = 1

var active_area: Node2D
var active_area_number
var selected_actions: Array[Dictionary] = []

func _ready() -> void:
	hide_actions()

	Dialogic.start("first_scene")
	Dialogic.signal_event.connect(func(event):
		if event == "start_music":
			CurrentLoop.start_music()
	)
	Dialogic.timeline_ended.connect(show_actions)

func show_actions():
	for action in get_tree().get_nodes_in_group('action'):
		if action is Action:
			action.show()

func hide_actions():
	for action in get_tree().get_nodes_in_group('action'):
		if action is Action:
			action.hide()
			action.action_pressed.connect(add_action)

func add_action(action_id: String, action_description: String):
	if selected_actions.size() == max_actions:
		return

	var action_index_found = -1

	for i in selected_actions.size():
		if selected_actions[i].action_id == action_id:
			action_index_found = i
			break

	if action_index_found == -1:
		selected_actions.push_back({
			"action_id": action_id,
			"action_description": action_description
		})

	if action_id == "A":
		$WardrobeOpen.show()
	elif action_id == "C":
		$DrawersOpen.show()

	for action in get_tree().get_nodes_in_group('action'):
		if action is Action:
			action.hide()

	confirm_actions()

func confirm_actions():
	if selected_actions.size() != max_actions:
		return
	CurrentLoop.add_actions(level_number, selected_actions)

	var timeline = "1%s-confirm" % selected_actions[0].action_id
	Dialogic.start_timeline(timeline)
	Dialogic.timeline_ended.connect(func():
		get_tree().change_scene_to_file("res://Scenes/Scene2/scene_2.tscn")
	)

func remove_action(action_id: String):
	var action_index_found = -1

	for i in selected_actions.size():
		if selected_actions[i].action_id == action_id:
			action_index_found = i
			break

	if action_index_found != -1:
		selected_actions.pop_at(action_index_found)
