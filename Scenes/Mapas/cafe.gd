extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print_tree()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_trigger_dialogue_2_body_entered(body):
	if body.name == "Player" && State.dialogue2_foi == false:
		State.dialogue2_foi = true
		get_node("TriggerDialogue2/acionaveis").start_dialogue()
