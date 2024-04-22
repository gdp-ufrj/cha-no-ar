extends Area2D

class_name Interactable
@onready var timer = $Timer

@export_enum("Dialogue", "Seat", "Door", "Tea", "Counter") var type: String

var should_ignore_interaction = false

@export_group("Dialogue")
@export var dialogue_resource: DialogueResource
@export var dialogue_owner: String
@export var recipe_book : Control

var dialogue_spot: int = 0
var dialogue_day: String

@onready var player_reference : CharacterBody2D = State.get_player_reference()

@export_group("Teleporting")
@export var portal: String = ""
@export var number: int = 1

@export_group("Seat")
@export var taken : bool = false

func get_assentos_dictionary():
	return State.assentos_dictionary

func update_assentos_dictionary(assentos_dictionary):
	State.assentos_dictionary = assentos_dictionary

func despawn_timer(time : int = 60):
	timer.start(time)
	pass
	
func _on_timer_timeout():
	State.remove_npc(dialogue_owner)

func start_dialogue() -> void:
	dialogue_day = State.current_day
	
	var should_advance_dialogue_spot = true
	var assentos_dictionary = get_assentos_dictionary()
	
	var dialogue_dictionary = State.get_dialogue_dictionary()
	
	if (get_parent().name.begins_with("Assento")): 
		var assento = get_parent()
		
		should_advance_dialogue_spot = false
		if (player_reference.has_drink_in_hand and assentos_dictionary[assento.name]["waiting_for_drink"]):
			dialogue_dictionary[dialogue_owner][dialogue_day]["spot"] = dialogue_dictionary[dialogue_owner][dialogue_day]["spot"] + 1
			assentos_dictionary[assento.name]["waiting_for_drink"] = false
			update_assentos_dictionary(assentos_dictionary)
			should_advance_dialogue_spot = true
			

	if !dialogue_dictionary.has(dialogue_owner):
		dialogue_dictionary[dialogue_owner] = {"forks": {}}
		dialogue_dictionary[dialogue_owner][dialogue_day] = {
			"spot": 0,
			"finished": false,
		}

	dialogue_spot = dialogue_dictionary[dialogue_owner][dialogue_day]["spot"]
	var dialogue_marker = dialogue_owner + "_" + dialogue_day + "_" + str(dialogue_spot)

	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_marker)
	
	if !dialogue_dictionary[dialogue_owner][dialogue_day]["finished"] && should_advance_dialogue_spot:
		dialogue_dictionary[dialogue_owner][dialogue_day]["spot"] = dialogue_dictionary[dialogue_owner][dialogue_day]["spot"] + 1

	State.overwrite_dialogue_dictionary(dialogue_dictionary)
