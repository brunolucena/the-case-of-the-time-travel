class_name Action
extends Node2D

signal action_pressed(action_id: String, action_description: String)

@export var action_id: String
@export var action_description: String


func _ready() -> void:
	$TextContainer.hide()

func _on_area_2d_mouse_entered() -> void:
	$TextContainer.show()

func _on_area_2d_mouse_exited() -> void:
	$TextContainer.hide()

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			emit_signal("action_pressed", action_id, action_description)
