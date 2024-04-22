extends Node2D

@onready var cat_spawning_locations = $cat_spawning_locations

var cat = preload("res://Scenes/cat.tscn")

@onready var spots = cat_spawning_locations.get_children()

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
