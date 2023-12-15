extends ColorRect


func _ready() -> void:
	color = "#ffffff"
	$AnimationPlayer.play("fade_out")
	$AnimationPlayer.animation_finished.connect(func(_animation_name: String): hide())
