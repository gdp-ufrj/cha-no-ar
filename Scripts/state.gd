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
########Tentando fazer funcionar
var npc_1 = load("res://Resources/NPCS/NPC_1.tres")
var npc_2 = load("res://Resources/NPCS/NPC_2.tres")
var npc_3 = load("res://Resources/NPCS/NPC_3.tres")
var npc_4 = load("res://Resources/NPCS/NPC_4.tres")
var npc_5 = load("res://Resources/NPCS/NPC_5.tres")
var npc_6 = load("res://Resources/NPCS/NPC_6.tres")
var npc_7 = load("res://Resources/NPCS/NPC_7.tres")
var npc_8 = load("res://Resources/NPCS/NPC_8.tres")
var npc_array= [npc_1,npc_2,npc_3,npc_4,npc_5,npc_6,npc_7,npc_8]

###############
var npc_resource = load("res://Resources/npc_	resource.gd")
var Assento_Marker
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

func spawn_npc():
	var npc_image = Sprite2D.new()
	
	
func assento_assigner(customer_resource: NPC_Resource):
	#customer_resource: recebe um NPC_Resource
	#atribui a var assento_keys os assentos_dictionary keys, ou seja
	#assento_1, assento_2
	var assento_keys = assentos_dictionary.keys()
	#cria um array com os assentos livres
	var assentos_livres = []
	#para x no numero de assento_keys(12)>
	for assento in assento_keys:
		#se, ao checar assentos_dictionary[x] ter uma string diferente de "ocupado'
		#>
		if !assentos_dictionary[assento]["ocupado"]:
			#adiciona ao array assentos_livres > assentos_livres[3]
			assentos_livres.append(assento)
	#cria variavel qtd_assentos_livres com base no tamanho do array assentos_livres
	var qtd_assentos_livres = assentos_livres.size()
	#cria var assento_escolhido e com faz um numero aleatorio
	#ex assentos_livres[2]
	#esse numero aleatorio vai de 0 até a qtd_assentos_livres-1
	var assento_escolhido = assentos_livres[randi_range(0,qtd_assentos_livres-1)]
	#então, pega assentos_dictionary e acessa a chave customer
	#ex: assentos_dictionary[3][NPC_1]
	assentos_dictionary[assento_escolhido]["customer"] = customer_resource
	#muda ex: assentos_dictionary[3]["ocupado"] pra true
	assentos_dictionary[assento_escolhido]["ocupado"] = true
	
func free_assento(assento_key):
	assentos_dictionary[assento_key]["ocupado"] = false
	assentos_dictionary[assento_key]["customer"] = null

func get_assentos():
	return assentos_dictionary

func troca_sprite():
	pass
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

