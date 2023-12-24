extends Node2D

func _on_trigger_dialogue_1_body_entered(body):
	if body.name == "Player" && State.dialogue1_foi == false:
		State.dialogue1_foi = true
		get_node("TriggerDialogue1/acionaveis").start_dialogue()
