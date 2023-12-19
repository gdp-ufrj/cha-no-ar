extends Control
@onready var receitas = $"."
@onready var cha_amarelo = $"../../SpawnCha/CháAmarelo"
var aberto = false
	
var card = preload("res://Scenes/Cards.tscn")

var drinks: Array
var page_limit: int
var current_page: int = 0
@onready var drink_sprite: Sprite2D = get_node("Background/Drink Sprite")
@onready var drink_name_label: Label = get_node("Background/Drink Name")
@onready var drink_ingredients_label: Label = get_node("Background/Ingredients Label/Drink Ingredients")
@onready var drink_description_label: RichTextLabel = get_node("Background/Description Label/Drink Description")
@onready var next_drink_button: Button = get_node("Background/Next Tea")
@onready var previous_drink_button: Button = get_node("Background/Previous Tea")
@onready var make_tea_button: Button = get_node("Background/Make Tea")

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
	
func set_info(drink: Drink_Resource):
	if drink.Drink_Image:
		drink_sprite.texture = load(drink.Drink_Image)
	else: 
		drink_sprite.texture = load("res://Assets/sprites/ui/Chá.png")
	drink_name_label.text = drink.Drink_Name
	drink_ingredients_label.text = drink.Drink_Description
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
		

func toggle_recipe_book():
	aberto = !aberto
	

	
