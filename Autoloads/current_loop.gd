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

var music_choice_path = "res://Autoloads/musics/TTT_CHOICE_v2.mp3"
var music_crime_scene_path = "res://Autoloads/musics/TTT_CRIME_SCENE_v2.mp3"

@onready var MusicPlayer = $MusicPlayer


func add_actions(scene_position: int, scene_actions: Array[Dictionary]):
	actions[scene_position] = scene_actions
	to_next_scene()

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

func to_ending():
	get_tree().change_scene_to_file("res://Scenes/Endings/ending_test.tscn")
	MusicPlayer.stop()
	MusicPlayer.stream = load(music_choice_path)
	MusicPlayer.play()

func to_first_scene():
	get_tree().change_scene_to_file("res://Scenes/Scene1/scene_1.tscn")
	MusicPlayer.stream = load(music_crime_scene_path)
	MusicPlayer.play()

func to_next_scene():
	if current_scene == last_scene_position:
		to_ending()
		return

	var actions_as_string = get_scene_actions_ids(current_scene)
	var next_scene_path = "res://Scenes/Scene{scene_position}/scene_{scene_position}_{actions}.tscn"
	var next_scene_path_formated = next_scene_path.format({
		"scene_position": current_scene + 1,
		"actions": actions_as_string,
	})

	get_tree().change_scene_to_file(next_scene_path_formated)

	current_scene += 1
