extends Control

var aberto = false

var carriable_object = preload("res://Scenes/carriable_object.tscn")

@export var fase : Node2D
@export var coffee_counter : Marker2D

var drinks: Array
var page_limit: int
var current_page: int = 0

@onready var drink_sprite = $"Background/Drink Sprite"
@onready var drink_name_label = $"Background/Drink Name"
@onready var drink_ingredients_label = $"Background/Ingredients Label/Drink Ingredients"
@onready var drink_description_label = $"Background/Description Label/Drink Description"
@onready var previous_drink_button = $"Background/Previous Tea"
@onready var next_drink_button = $"Background/Next Tea"
@onready var make_tea_button = $"Background/Make Tea"

@onready var player_reference = State.get_player_reference()

func _ready():
	get_drink_resources()
	set_info(drinks[0])
	check_buttons()
		
func get_drink_resources():
	var path = "res://Resources/Drinks/"
	
	var drink_directory = DirAccess.open(path)
	drink_directory.list_dir_begin()
	var file_name = drink_directory.get_next()
	while file_name != "":
		var drink_resource = load(path + file_name)
		drinks.append(drink_resource)
		file_name = drink_directory.get_next()
	page_limit = drinks.size() - 1
	
func set_info(drink: Resource):
	drink_sprite.texture = load(drink.Drink_Image)
	drink_name_label.text = drink.Drink_Name
	drink_ingredients_label.text = drink.Drink_Ingredients
	drink_description_label.text = drink.Drink_Description
	
func next_drink():
	current_page = current_page + 1
	set_info(drinks[current_page])
	check_buttons()
	
func previous_drink():
	current_page = current_page - 1
	set_info(drinks[current_page])
	check_buttons()
	
func check_buttons():
	if current_page == 0:
		previous_drink_button.disabled = true
	else:
		previous_drink_button.disabled = false
		
	if current_page == page_limit:
		next_drink_button.disabled = true
	else:
		next_drink_button.disabled = false
		
func make_tea():
	$FillingTea.play()
	
	player_reference.has_drink_in_hand = true
	player_reference.drink_in_hand = drinks[current_page]
	State.set_held_drink_tags(drinks[current_page].Drink_Tags)
	
	self.visible = !self.visible
	
func close_menu():
	self.visible = !self.visible
	
func toggle_recipe_book():
	self.visible = !aberto
	aberto = !aberto

	
