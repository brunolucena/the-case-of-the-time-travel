extends Node

var actions = {
	1: [],
	2: [],
	3: [],
	4: [],
	5: [],
}
var current_scene = 1
var last_scene_position = 2

var music_crime_scene_path = "res://Autoloads/musics/TTT_MUSIC & SFX/TTT_MUSIC/TTT_MUS_CRIME SCENE PAST.wav"

@onready var MusicPlayer: AudioStreamPlayer = $MusicPlayer


func add_actions(scene_position: int, scene_actions: Array[Dictionary]):
	actions[scene_position] = scene_actions

func get_scene_actions_ids(scene_position: int) -> String:
	var scene_actions_mapped_sorted = actions[scene_position].map(func(action): return action.action_id)
	scene_actions_mapped_sorted.sort()

	var actions_as_string = ''
	for action in scene_actions_mapped_sorted:
		actions_as_string += action
	return actions_as_string

func get_scene_actions_as_string(scene_position: int) -> String:
	var actions_as_string = 'Scene %s:' % [scene_position]
	for action in actions[scene_position]:
		actions_as_string += '\n%s' % action.action_description

	return actions_as_string

func reset():
	current_scene = 1

func start_music():
	if not MusicPlayer.playing:
		MusicPlayer.stream = load(music_crime_scene_path)
		MusicPlayer.play()

func stop_music():
	MusicPlayer.stop()

func to_ending():
	print("to_ending")
	get_tree().change_scene_to_file("res://Scenes/Endings/ending_test.tscn")
	MusicPlayer.stop()

func to_first_scene():
	get_tree().change_scene_to_file("res://Scenes/Scene1/scene_1.tscn")

func to_next_scene():
	print("to_next_scene", {"current_scene": current_scene, "last_scene_position": last_scene_position})
	if current_scene == 1:
		MusicPlayer.stop()
		start_music()

		get_tree().change_scene_to_file("res://Scenes/Scene2/scene_2.tscn")

		current_scene += 1
	elif current_scene == 2:
		to_ending()
		return


