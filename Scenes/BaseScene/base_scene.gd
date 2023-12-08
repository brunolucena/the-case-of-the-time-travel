class_name Scene
extends Node2D

@export var level_number: int

var max_actions = 3

var active_area: Node2D
var active_area_number
var selected_actions: Array[Dictionary] = []

@onready var ActionItem = preload("res://Scenes/ActionsList/action_item.tscn")
@onready var ActionsList = $ActionsList as ActionsList

func _ready() -> void:
	CurrentLoop.start_music()
	active_area = $OverviewArea
	for action in get_tree().get_nodes_in_group('action'):
		if action is Action:
			action.action_pressed.connect(add_action)
	for back_button in get_tree().get_nodes_in_group("back_button"):
		if back_button is Button:
			back_button.pressed.connect(to_main_scene)
	for next_button in get_tree().get_nodes_in_group("next_button"):
		if next_button is Button:
			next_button.pressed.connect(to_next_area)
	for previous_button in get_tree().get_nodes_in_group("previous_button"):
		if previous_button is Button:
			previous_button.pressed.connect(to_previous_area)


func _input(event: InputEvent) -> void:
	if active_area == $OverviewArea:
		if event.is_action_pressed("area_top"):
			change_area(1)
		elif event.is_action_pressed("area_left"):
			change_area(2)
		elif event.is_action_pressed("area_bottom"):
			change_area(3)
		elif event.is_action_pressed("area_right"):
			change_area(4)
	else:
		if event.is_action_pressed("cancel") || event.is_action_pressed("main_area"):
			to_main_scene()
		elif event.is_action_pressed("next_area"):
			to_next_area()
		elif event.is_action_pressed("previous_area"):
			to_previous_area()

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
		var new_action = ActionItem.instantiate()
		new_action.set_text(action_description)
		new_action.get_remove_button().connect('pressed', remove_action.bind(action_id))
		ActionsList.add_item(new_action)

func change_area(area_number: int):
	var next_area = get_node("Area" + str(area_number))

	if next_area is Node2D:
		active_area.hide()
		next_area.show()
		active_area = next_area
		active_area_number = area_number

func confirm_actions():
	if selected_actions.size() != 3:
		return
	CurrentLoop.add_actions(level_number, selected_actions)

func remove_action(action_id: String):
	var action_index_found = -1

	for i in selected_actions.size():
		if selected_actions[i].action_id == action_id:
			action_index_found = i
			break

	if action_index_found != -1:
		selected_actions.pop_at(action_index_found)
		ActionsList.remove_item(action_index_found)

func to_main_scene():
	active_area.hide()
	active_area_number = null

	$OverviewArea.show()
	active_area = $OverviewArea

func to_next_area():
	var next_area_number = active_area_number + 1

	if next_area_number == 5:
		next_area_number = 1

	change_area(next_area_number)

func to_previous_area():
	var next_area_number = active_area_number - 1

	if next_area_number == 0:
		next_area_number = 4

	change_area(next_area_number)

func _on_confirm_button_pressed() -> void:
	confirm_actions()

func _on_overview_area_area_changed(area_number: int) -> void:
	change_area(area_number)
