extends Node

var container: VBoxContainer
var drink_resource: Resource
var button: Button

func _ready():
	container = self.get_parent()

func set_infos(received_drink_resource: Resource):
	drink_resource = received_drink_resource
	self.text = drink_resource.Drink_Name
	if drink_resource.Drink_Image:
		self.icon = load(drink_resource.Drink_Image)
	else: 
		self.icon = load("res://Assets/sprites/ui/Chá.png")
		
func _on_card_button_pressed():
	var carriable_object = load("res://Scenes/carriable_object.tscn")
	var drink = carriable_object.instantiate()
	var drink_stand_location = get_node("../../../../../../DrinkStand").global_position
	drink.set_object_data(drink_resource, drink_stand_location)
	get_node("../../../../../../../fase").add_child(drink)
