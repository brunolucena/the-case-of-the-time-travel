extends Node2D

@onready var animation_player = $"%AnimationPlayer"

var current_scene = 0
var last_scene = 9


func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	play_scene(current_scene)
	current_scene += 1
	animation_player.queue("%s" % current_scene)


func _input(event: InputEvent) -> void:
	if OS.is_debug_build():
		if event is InputEventKey:
			if event.keycode == KEY_ESCAPE and event.is_pressed():
				animation_player.stop()
				Dialogic.end_timeline()
				start_game()

	var can_interact =  not animation_player.is_playing() and current_scene != 0

	if event.is_action_pressed("dialogic_default_action"):
		if can_interact:
			current_scene += 1
			play_scene(current_scene)


func play_scene(scene: int):
	if scene == last_scene + 1:
		start_game()
	else:
		animation_player.play("%s" % scene)


func start_game():
	get_tree().change_scene_to_file("res://Scenes/DoTimeTravel/do_time_travel.tscn")
