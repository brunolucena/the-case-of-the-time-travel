extends Node2D


func _ready() -> void:
	CurrentLoop.reset()

func _on_button_pressed() -> void:
	CurrentLoop.to_first_scene()
