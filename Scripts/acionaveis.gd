extends Area2D

@export_group("Dialogue")
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

@export_group("Teleporting")
@export var portal: String = ""

func start_dialogue() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
