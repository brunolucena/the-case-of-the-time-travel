class_name ActionItem
extends HBoxContainer


func set_text(text: String):
	$Text.text = text

func get_remove_button() -> Button:
	return $Remove
