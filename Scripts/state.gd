extends Node

var estado = {
	"current_scene" = "fase",
	"transition_scene" = false,
	"capuccino_count" = 1,
	"emocao_count" = 0,
	"dialogue_dictionary" = {}
}
var assentos_dictionary = {
	"Assento_1":{"ocupado": false,"local":"cafe","customer": NPC_Resource},
	"Assento_2":{"ocupado": false,"local":"cafe","customer": NPC_Resource},
	"Assento_3":{"ocupado": false,"local":"cafe","customer": NPC_Resource},
	"Assento_4":{"ocupado": false,"local":"cafe","customer": NPC_Resource},
	"Assento_5":{"ocupado": false,"local":"cafe","customer": NPC_Resource},
	"Assento_6":{"ocupado": false,"local":"cafe","customer": NPC_Resource},
	"Assento_7":{"ocupado": false,"local":"varanda","customer": NPC_Resource},
	"Assento_8":{"ocupado": false,"local":"varanda","customer": NPC_Resource},
	"Assento_9":{"ocupado": false,"local":"varanda","customer": NPC_Resource},
	"Assento_10":{"ocupado": false,"local":"varanda","customer": NPC_Resource},
	"Assento_11":{"ocupado": false,"local":"varanda","customer": NPC_Resource},
	"Assento_12":{"ocupado": false,"local":"varanda","customer": NPC_Resource}
}

var npc_resource = load("res://Resources/npc_resource.gd")
var current_scene = "fase"
var transition_scene = false
@onready var player = get_node("Player")
var talking_to
var drink_resource: Resource
var dialogue_dictionary: Dictionary

var held_drink_tags: Array

var capuccino_count: int = 1
var emocao_count: int = 0

var comparation: int = 0

func assento_assigner(customer_resource: NPC_Resource):
	var assento_keys = assentos_dictionary.keys()
	var assentos_livres = []
	for assento in assento_keys:
		if !assentos_dictionary[assento]["ocupado"]:
			assentos_livres.append(assento)
	var qtd_assentos_livres = assentos_livres.size()
	var assento_escolhido = assentos_livres[randi_range(0,qtd_assentos_livres-1)]
	assentos_dictionary[assento_escolhido]["customer"] = customer_resource
	assentos_dictionary[assento_escolhido]["ocupado"] = true
	
func free_assento(assento_key):
	assentos_dictionary[assento_key]["ocupado"] = false
	assentos_dictionary[assento_key]["customer"] = null

func get_assentos():
	return assentos_dictionary

#func troca_sprite():
#	assentos_dictionary[.]
#	pass

func update_sprite():
	pass
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

func getEmocao():
	return emocao_count

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
