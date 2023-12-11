extends VBoxContainer

var card = preload("res://Scenes/Cards.tscn")

func _ready():
	var drinks = []
	var path = "res://Resources/Drinks/"
	
	var drink_directory = DirAccess.open(path)
	drink_directory.list_dir_begin()
	var file_name = drink_directory.get_next()
	while file_name != "":
		print(file_name)
		var drink_resource = load(path + file_name)
		var card_instance = card.instantiate()
		card_instance.set_infos(drink_resource)
		self.add_child(card_instance)
		file_name = drink_directory.get_next()
			
	print(drinks)
	
