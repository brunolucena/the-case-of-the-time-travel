extends Node2D


func _on_back_button_pressed() -> void:
	var parent = get_parent()
	if parent is BaseScene:
		parent.to_main_scene()

func _on_next_button_pressed() -> void:
	var parent = get_parent()
	if parent is BaseScene:
		parent.to_next_area()

func _on_previous_button_pressed() -> void:
	emit_signal("previous_pressed")
	var parent = get_parent()
	if parent is BaseScene:
		parent.to_previous_area()
