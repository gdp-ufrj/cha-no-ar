extends Area2D

@export_enum("Dialogue", "Door", "Carry", "Functional") var type: String

@export_group("Dialogue")
@export var dialogue_resource: DialogueResource
@export var dialogue_owner: String
var dialogue_spot

@export_group("Teleporting")
@export var portal: String = ""

func start_dialogue() -> void:
	var dialogue_dictionary = State.get_dialogue_dictionary()
	
	print(dialogue_owner)
	
	if !dialogue_dictionary.has(dialogue_owner):
		dialogue_dictionary[dialogue_owner] = {
			"spot": 0,
			"finished": false,
			"forks": {}
		}
	
	print(dialogue_dictionary)
	
	dialogue_spot = dialogue_dictionary[dialogue_owner]["spot"]
	var dialogue_marker = dialogue_owner + "_" + str(dialogue_spot)
	
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_marker)
	
	if !dialogue_dictionary[dialogue_owner]["finished"]:
		dialogue_dictionary[dialogue_owner]["spot"] = dialogue_dictionary[dialogue_owner]["spot"] + 1
	
	State.overwrite_dialogue_dictionary(dialogue_dictionary)
