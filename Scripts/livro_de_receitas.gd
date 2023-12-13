extends Control
@onready var receitas = $"."
@onready var cha_amarelo = $"../../SpawnCha/CháAmarelo"
var aberto = false
	
var card = preload("res://Scenes/Cards.tscn")

var drinks: Array
var page_limit: int
var current_page: int

func _ready():
	get_drink_resources()
		
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
	print(page_limit)
	
func set_info(drink: Drink_Resource):
	

func toggle_recipe_book():
	aberto = !aberto
	

	
