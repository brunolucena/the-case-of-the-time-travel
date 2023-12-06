class_name BaseScene
extends Node2D


var active_area: Node2D
var active_area_number


func _ready() -> void:
	active_area = $OverviewArea

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

func change_area(area_number: int):
	var next_area = get_node("Area" + str(area_number))

	if next_area is Node2D:
		active_area.hide()
		next_area.show()
		active_area = next_area
		active_area_number = area_number

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

func _on_overview_area_area_changed(area_number: int) -> void:
	change_area(area_number)
