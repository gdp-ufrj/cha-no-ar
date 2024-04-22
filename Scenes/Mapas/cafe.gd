extends Node2D

@onready var acionaveis = $shop_entrance_dialogue/acionaveis
@onready var player_reference = State.get_player_reference()
@onready var cat_spawning_locations = $cat_spawning_locations
@onready var spots = cat_spawning_locations.get_children()

var cat = preload("res://Scenes/cat.tscn")

func _on_trigger_dialogue_2_body_entered(body):
	if body.name == "Player" && State.dialogue2_foi == false:
		player_reference.remove_player_speed()
		acionaveis.start_dialogue()
		await DialogueManager.dialogue_ended
		State.dialogue2_foi = true

func clear_spots():
	for spot in spots:
		if spot.get_child_count() == 0:
			continue
		spot.get_child(0).queue_free()

func select_new_cat_spot():
	var selected_spot = spots.pick_random()
	
	var cat_instance = cat.instantiate()
	var cat_stance = selected_spot.cat_stance
	selected_spot.add_child(cat_instance)
	
	cat_instance.choose_cat_animation()
	

func _ready():
	clear_spots()
	select_new_cat_spot()
