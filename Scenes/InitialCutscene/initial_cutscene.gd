extends Node2D

@onready var animation_player = $"%AnimationPlayer"


func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	animation_player.play("enter")
	animation_player.queue("enter2")

	Dialogic.connect('signal_event', func(argument: String):
		print(argument)
		if argument == "ended":
			start_game()
	)


func _input(event: InputEvent) -> void:
	if OS.is_debug_build():
		if event is InputEventKey:
			if event.keycode == KEY_ESCAPE and event.is_pressed():
				animation_player.stop()
				start_game()


func start_dialog():
	Dialogic.start("initial_cutscene_1")


func start_game():
	Dialogic.end_timeline()
	get_tree().change_scene_to_file("res://Scenes/DoTimeTravel/do_time_travel.tscn")
