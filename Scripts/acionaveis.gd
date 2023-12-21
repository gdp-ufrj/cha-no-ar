extends Area2D

@export_enum("Dialogue", "Door", "Carry") var type: String

@export_group("Dialogue")
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
var dialogue_spot: int = 0

@export_group("Teleporting")
@export var portal: String = ""
@export var number: int = 1

func start_dialogue() -> void:
	var dialogue_marker = dialogue_start + "_" + str(dialogue_spot)
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_marker)
	dialogue_spot = dialogue_spot + 1
