eeextends Area2D

@export_enum("Dialogue", "Door", "Carry") var type: String

@export_group("Dialogue")
@export var dialogue_resource: DialogueResource
@export var dialogue_owner: String
var dialogue_spot
@export_group("Teleporting")
@export var portal: String = ""
@export var number: int = 1

@onready var moldura_player = $"."


func start_dialogue() -> void:
	var dialogue_dictionary = State.get_dialogue_dictionary()
	
	if !dialogue_dictionary.has(dialogue_owner):
		dialogue_dictionary[dialogue_owner] = {
			"spot": 0,
			"finished": false,
			"forks": {}
		}
	
	dialogue_spot = dialogue_dictionary[dialogue_owner]["spot"]
	var dialogue_marker = dialogue_owner + "_" + str(dialogue_spot)
	
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_marker)
	var dialogue_line = await dialogue_resource.get_next_dialogue_line("Adonis_Day_1_0")
	if !dialogue_dictionary[dialogue_owner]["finished"]:
		dialogue_dictionary[dialogue_owner]["spot"] = dialogue_dictionary[dialogue_owner]["spot"] + 1
	
	State.overwrite_dialogue_dictionary(dialogue_dictionary)
func character_emotion(dialogue_line):
	var characterEmotion : Dictionary
	var array: Array
	for tag in dialogue_line.tags:
		array = tag.split(":")
		characterEmotion[array[0]] = array[1]
	return characterEmotion
	
#pega um personagem e uma emoção e retorna um path da imagem respectiva
func paths_images(dialogue_line):
	var characterEmotion : Dictionary = character_emotion(dialogue_line)
	var list_names : Array = characterEmotion.keys()
	var array_paths : Array = ["res://Assets/sprites/"+list_names[0]+"/"+characterEmotion[list_names[0]]+"/"+characterEmotion[list_names[0]]+"1","res://Assets/sprites/"+list_names[1]+"/"+characterEmotion[list_names[1]]+"/"+characterEmotion[list_names[1]]+"1" ]
	return array_paths
func substitute_image(sprite_leia:Sprite2D, sprite_npc : Sprite2D , dialogue_line):
	var array_paths : Array = paths_images(dialogue_line)
	sprite_leia.texture = load(array_paths[0])
	sprite_npc.texture = load(array_paths[0])
	return
