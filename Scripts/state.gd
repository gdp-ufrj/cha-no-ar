extends Node

var estado = {
	"current_scene" = "fase",
	"transition_scene" = false,
	"capuccino_count" = 1,
	"emocao_count" = 0,
	"assigned_sprites" = false,
	"dialogue_dictionary" = {},
	"should_free_cafe_assentos" = false,
	"should_free_varanda_assentos" = false
}

var assentos_dictionary = {
	"Assento_1":{"ocupado": false,"local":"cafe","customer": null, "key": "Assento_1"},
	"Assento_2":{"ocupado": false,"local":"cafe","customer": null, "key": "Assento_2"},
	"Assento_3":{"ocupado": false,"local":"cafe","customer": null, "key": "Assento_3"},
	"Assento_4":{"ocupado": false,"local":"cafe","customer": null, "key": "Assento_4"},
	"Assento_5":{"ocupado": false,"local":"cafe","customer": null, "key": "Assento_5"},
	"Assento_6":{"ocupado": false,"local":"cafe","customer": null, "key": "Assento_6"},
	"Assento_7":{"ocupado": false,"local":"varanda","customer": null, "key": "Assento_7"},
	"Assento_8":{"ocupado": false,"local":"varanda","customer": null, "key": "Assento_8"},
	"Assento_9":{"ocupado": false,"local":"varanda","customer": null, "key": "Assento_9"},
	"Assento_10":{"ocupado": false,"local":"varanda","customer": null, "key": "Assento_10"},
	"Assento_11":{"ocupado": false,"local":"varanda","customer": null, "key": "Assento_11"},
	"Assento_12":{"ocupado": false,"local":"varanda","customer": null, "key": "Assento_12"}
}

var npcs_in_cafe: Array = []
var npcs_in_varanda: Array = []

var current_scene = "fase"
var transition_scene = false
var talking_to
var drink_resource: Resource
var dialogue_dictionary: Dictionary

var cafe_seating_group: Node
var varanda_seating_group: Node

var current_day: String = "Day_1"

var held_drink_tags: Array

var capuccino_count: int = 1
var emocao_count: int = 0

var comparation: int = 0

func has_assigned_sprites():
	return estado.assigned_sprites

func get_spawn_list():
	var spawn_list = load("res://Resources/SpawnLists/" + current_day + ".tres")
	return spawn_list.Day_NPCs_Paths

func assento_assigner(npc: NPC_Resource):
	var assento_keys = assentos_dictionary.keys()
	
	var assentos_livres = assento_keys.filter(func (key):
		return assentos_dictionary[key]["ocupado"] == false
		)

	var assento_escolhido_key = assentos_livres.pick_random()
		
	var assento_local = assentos_dictionary[assento_escolhido_key]["local"]
	
	assentos_dictionary[assento_escolhido_key]["customer"] = npc
	assentos_dictionary[assento_escolhido_key]["ocupado"] = true
	
func assign_all_day_NPCs():
	if not estado.assigned_sprites:
		npc_sprites()
	
	var spawn_list = get_spawn_list()
	
	for npc_path in spawn_list:
		print("npc_path:", npc_path)
		var npc_resource = load(npc_path)
		print("npc_resource:", npc_resource.NPC_Sprite)
		assento_assigner(npc_resource)
	
func free_cafe_assentos():
	var assento_keys = assentos_dictionary.keys()
	
	var cafe_assentos_ocupados = assento_keys.filter(func (key):
		return assentos_dictionary[key]["ocupado"] == true and assentos_dictionary[key]["local"] == "cafe"
		)
	
	if !cafe_assentos_ocupados.is_empty():
		for assento in cafe_assentos_ocupados:
			assentos_dictionary[assento]["ocupado"] = false
			var npc_sprite = cafe_seating_group.get_node(assento + "/Sprite2D")
			npc_sprite.texture = null
			var assento_interactor = cafe_seating_group.get_node(assento + "/acionaveis")
			assento_interactor.should_ignore_interaction = true
			
func free_varanda_assentos():
	var assento_keys = assentos_dictionary.keys()
	
	var varanda_assentos_ocupados = assento_keys.filter(func (key):
		return assentos_dictionary[key]["ocupado"] == true and assentos_dictionary[key]["local"] == "varanda"
		)
	
	if !varanda_assentos_ocupados.is_empty():
		for assento in varanda_assentos_ocupados:
			assentos_dictionary[assento]["ocupado"] = false
			var npc_sprite = varanda_seating_group.get_node(assento + "/Sprite2D")
			npc_sprite.texture = null
			var assento_interactor = varanda_seating_group.get_node(assento + "/acionaveis")
			assento_interactor.should_ignore_interaction = true
	
func spawn_npcs_cafe():
	var assento_keys = assentos_dictionary.keys()
	
	var cafe_assentos_ocupados = assento_keys.filter(func (key):
		return assentos_dictionary[key]["ocupado"] == true and assentos_dictionary[key]["local"] == "cafe"
		)

	if !cafe_assentos_ocupados.is_empty():
		for assento in cafe_assentos_ocupados:
			var assento_node = cafe_seating_group.get_node(assento)
			var assento_sprite = assento_node.get_node("Sprite2D")
			var assento_interactor = assento_node.get_node("acionaveis")
			var npc_resource = assentos_dictionary[assento]["customer"]
			print("npc_resource:", npc_resource.NPC_Sprite)
			
			assento_interactor.dialogue_resource = npc_resource.NPC_Dialogue
			assento_interactor.dialogue_owner = npc_resource.NPC_key_name
			assento_sprite.texture = load(npc_resource.NPC_Sprite)
			
func spawn_npcs_varanda():
	var assento_keys = assentos_dictionary.keys()
	
	var varanda_assentos_ocupados = assento_keys.filter(func (key):
		return assentos_dictionary[key]["ocupado"] == true and assentos_dictionary[key]["local"] == "varanda"
		)
		
	if !varanda_assentos_ocupados.is_empty():
		for assento in varanda_assentos_ocupados:
			var assento_node = varanda_seating_group.get_node(assento)
			var assento_sprite = assento_node.get_node("Sprite2D")
			var assento_interactor = assento_node.get_node("acionaveis")
			var npc_resource = assentos_dictionary[assento]["customer"]
			
			assento_interactor.dialogue_resource = npc_resource.NPC_Dialogue
			assento_interactor.dialogue_owner = npc_resource.NPC_key_name
			assento_sprite.texture = load(npc_resource.NPC_Sprite)

var male_sprites = []
var female_sprites = []

func get_sprites():
	var male_dir = DirAccess.open("res://Assets/sprites/npcs/Male Sprite/")
	var female_dir = DirAccess.open("res://Assets/sprites/npcs/Female Sprite/")
	if male_dir:
		male_dir.list_dir_begin()
		var file_name = male_dir.get_next()
		while file_name != "":
			if !file_name.contains(".import"):
				self.male_sprites.append({
					"address": "res://Assets/sprites/npcs/Male Sprite/" + file_name,
					"used": false
				})
			file_name = male_dir.get_next()

	if female_dir:
		female_dir.list_dir_begin()
		var file_name = female_dir.get_next()
		while file_name != "":
			if !file_name.contains(".import"):
				self.female_sprites.append({
					"address": "res://Assets/sprites/npcs/Female Sprite/" + file_name,
					"used": false
				})
			file_name = female_dir.get_next()

func get_available(sprites_arrays: Array):
	return sprites_arrays.filter(func (sprite):
		return sprite["used"] == false
		)
	
func set_npc_sprites_for_game():
	var dir = DirAccess.open("res://Resources/NPCS/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var npc = load("res://Resources/NPCS/" + file_name)
			var selectable_sprites: Array
			if npc.sprite_folder == "Female Sprite":
				selectable_sprites = get_available(female_sprites)
			else:
				selectable_sprites = get_available(male_sprites)
			npc.NPC_Sprite = selectable_sprites.pick_random().address
			print("npc.NPC_Sprite:", npc.NPC_Sprite)
			ResourceSaver.save(npc)
			file_name = dir.get_next()
		estado.assigned_sprites = true

func npc_sprites():
	get_sprites()
	set_npc_sprites_for_game()
	
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
	dialogue_dictionary[character_title][current_day]["finished"] = true

func mark_new_fork(character_title: String, fork_key: String, result: int):
	dialogue_dictionary[character_title]["forks"][fork_key] = result

func consult_fork_result(character_title: String, fork_key: String):
	return dialogue_dictionary[character_title]["forks"][fork_key]

func check_fork_exists(character_title: String, fork_key: String):
	print("fork_key:", fork_key)
	print("character_title:", character_title)
	return dialogue_dictionary[character_title]["forks"].has(fork_key)

func getEmocao():
	return emocao_count

func update_estado():
	pass
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

