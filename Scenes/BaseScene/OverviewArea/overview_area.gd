extends Node2D

signal area_changed(area_number: int)


func _ready() -> void:
	$ClickableAreas/Area1.modulate = Color(1, 1, 1, 0)
	$ClickableAreas/Area2.modulate = Color(1, 1, 1, 0)
	$ClickableAreas/Area3.modulate = Color(1, 1, 1, 0)
	$ClickableAreas/Area4.modulate = Color(1, 1, 1, 0)


func _on_area_mouse_entered(area_number: int) -> void:
	var area = get_node("ClickableAreas/Area" + str(area_number))
	if area is Node2D:
		area.modulate = Color(1, 1, 1, 1)


func _on_area_mouse_exited(area_number: int) -> void:
	var area = get_node("ClickableAreas/Area" + str(area_number))
	if area is Node2D:
		area.modulate = Color(1, 1, 1, 0)


func _on_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int, area_number: int) -> void:
	if (
			event is InputEventMouseButton
			and event.button_index == MOUSE_BUTTON_LEFT
			and event.is_pressed()
	):
		emit_signal("area_changed", area_number)
