extends PanelContainer


func _ready() -> void:
	$AnimationPlayer.play("do_animation")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	visible = true
	$CenterContainer/Label.modulate = "#ffffff00"
	hide()
