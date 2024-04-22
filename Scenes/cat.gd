extends Node2D

@onready var animation_player = $AnimationPlayer

const animaton_state_key_dictionary = {
	"Laying": "idle_laying_cat",
	"Sitting": "idle_seated_cat"
}

@onready var location = get_parent()

var current_cat_state : String

func get_cat_state():
	return location.cat_stance

func choose_cat_animation():
	current_cat_state = get_cat_state()
	animation_player.play(animaton_state_key_dictionary[current_cat_state])

func _ready():
	choose_cat_animation()
