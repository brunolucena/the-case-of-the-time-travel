class_name Action
extends Node2D

signal action_pressed(action_id: String, action_description: String)

@export var action_id: String
@export var action_description: String


func _ready() -> void:
	$CenterContainer/TextContainer.hide()

func _on_area_2d_mouse_entered() -> void:
	$CenterContainer/TextContainer.show()

func _on_area_2d_mouse_exited() -> void:
	$CenterContainer/TextContainer.hide()

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var timeline = "%s%s" % [get_parent().level_number, action_id]
			Dialogic.start(timeline)
			Dialogic.signal_event.connect(func(event):
				if event == 'yes':
					emit_signal("action_pressed", action_id, action_description)
			)
