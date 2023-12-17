extends Area2D

@export_enum("Dialogue", "Door", "Carry") var type: String

@export_group("Dialogue")
@export var dialogue_resource: DialogueResource
@export var dialogue_owner: String
var dialogue_spot

@export_group("Teleporting")
@export var portal: String = ""
@onready var dialogue_balloon = get_node("DialogueBalloon")
#func show_ballon(dialogue_resource, dialogue_marker):
#	var dialogue_line = await DialogueManager.get_next_dialogue_line(dialogue_resource,dialogue_marker)
#	if dialogue_line == null:
#		return 
#	print(dialogue_line)
#	if dialogue_line.responses.size() != 0:
#		print(dialogue_line.responses)
#	show_ballon(dialogue_resource, dialogue_line.next_id)
func show_ballon():
	dialogue_balloon.disable = false
func start_dialogue() -> void:
	print(get_tree().get_root())
	show_ballon()
	var dialogue_dictionary = State.get_dialogue_dictionary()
	
	
	if !dialogue_dictionary.has(dialogue_owner):
		dialogue_dictionary[dialogue_owner] = {
			"spot": 0,
			"finished": false,
			"forks": {}
		}
	
	print(dialogue_dictionary)
	
	dialogue_spot = dialogue_dictionary[dialogue_owner]["spot"]
	var dialogue_marker = dialogue_owner + "_" + str(dialogue_spot)
	
	
	if !dialogue_dictionary[dialogue_owner]["finished"]:
		dialogue_dictionary[dialogue_owner]["spot"] = dialogue_dictionary[dialogue_owner]["spot"] + 1
	
	State.overwrite_dialogue_dictionary(dialogue_dictionary)
