extends Area2D

@export_enum("Dialogue", "Door", "Carry") var type: String

var should_ignore_interaction = false
@export_group("Dialogue")
@export var dialogue_resource: DialogueResource
@export var dialogue_owner: String
var dialogue_spot: int = 0
var dialogue_day: String

@export_group("Teleporting")
@export var portal: String = ""
@export var number: int = 1

func start_dialogue() -> void:
	if should_ignore_interaction:
		return
	dialogue_day = State.current_day
	var dialogue_dictionary = State.get_dialogue_dictionary()

	if !dialogue_dictionary.has(dialogue_owner):
		dialogue_dictionary[dialogue_owner] = {"forks": {}}
		dialogue_dictionary[dialogue_owner][dialogue_day] = {
			"spot": 0,
			"finished": false,
		}

	dialogue_spot = dialogue_dictionary[dialogue_owner][dialogue_day]["spot"]
	var dialogue_marker = dialogue_owner + "_" + dialogue_day + "_" + str(dialogue_spot)

	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_marker)

	if !dialogue_dictionary[dialogue_owner][dialogue_day]["finished"]:
		dialogue_dictionary[dialogue_owner][dialogue_day]["spot"] = dialogue_dictionary[dialogue_owner][dialogue_day]["spot"] + 1

	State.overwrite_dialogue_dictionary(dialogue_dictionary)
