extends Node2D

signal back_button_pressed
signal next_buttom_pressed
signal previous_button_presed


func _on_back_button_pressed() -> void:
	emit_signal("back_button_pressed")

func _on_next_button_pressed() -> void:
	emit_signal("next_buttom_pressed")

func _on_previous_button_pressed() -> void:
	emit_signal("previous_button_presed")
