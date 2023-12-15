class_name ActionsList
extends Node2D

@onready var ConfirmButton = $PanelContainer/MarginContainer/VBoxContainer/ConfirmButton
@onready var Items = $PanelContainer/MarginContainer/VBoxContainer/Items


func add_item(item: ActionItem):
	Items.add_child(item)
	if Items.get_child_count() == 1:
		ConfirmButton.disabled = false

func remove_item(index: int):
	if is_instance_valid(Items.get_child(index)):
		Items.get_child(index).queue_free()
	ConfirmButton.disabled = true
