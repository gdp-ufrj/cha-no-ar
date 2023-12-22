extends Node

var estado = {
	"current_scene" = "fase",
	"transition_scene" = false,
	"capuccino_count" = 1,
	"emocao_count" = 0,
	"dialogue_dictionary" = {}
}

var current_scene = "fase"
var transition_scene = false
@onready var player = get_node("Player")
var talking_to
var drink_resource: Resource
var dialogue_dictionary = {}

var held_drink_tags: Array

var capuccino_count: int = 1
var emocao_count: int = 0

var dialogue_resource = load("res://Dialogo/main.dialogue")

var comparation: int = 0
	
func compare_tags(tags_asked: Array):
	var score = 0
	for asked in tags_asked:
		for delivered in held_drink_tags:
			if delivered == asked:
				score = score + 1
	return score

func get_dialogue_dictionary():
	return dialogue_dictionary
	
func overwrite_dialogue_dictionary(new_dialogue_dictionary):
	dialogue_dictionary = new_dialogue_dictionary
	
func mark_last_speaking_for_day(character_title: String):
	dialogue_dictionary[character_title]["finished"] = true

func mark_new_fork(character_title: String, fork_key: String, result: int):
	dialogue_dictionary[character_title]["forks"][fork_key] = result

func consult_fork_result(character_title: String, fork_key: String):
	return dialogue_dictionary[character_title]["forks"][fork_key]
	
func check_fork_exists(character_title: String, fork_key: String):
	return dialogue_dictionary[character_title]["forks"].has(fork_key)


#SALVAMENTO
const SAVE_GAME_PATH =  "user://progresso.save"
func save_game(): #tambem serve pra dar overwrite
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	file.store_var(estado)

func save_exists():
	if FileAccess.file_exists(SAVE_GAME_PATH):
		return true
	else:
		return false

func load_data():
	if FileAccess.file_exists(SAVE_GAME_PATH):
		var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
		estado = file.get_var()
