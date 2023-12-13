extends Button

var container: VBoxContainer
var drink_resource: Resource

func _ready():
	container = self.get_parent()
	var button = Button.new()
	button.pressed.connect(self.spawn_drink)

func set_infos(drink_resource_1: Resource):
	drink_resource = drink_resource_1
	self.text = drink_resource.Drink_Name
	if drink_resource.Drink_Image:
		self.icon = load(drink_resource.Drink_Image)
	else: 
		self.icon = load("res://Assets/sprites/ui/Chá.png")
		
func _on_time_():
	print("ouço a função")
	var drink_stand_location = get_node("DrinkStand").global_position
	var carriable_object = load("res://Scenes/carriable_object.tscn")
	var drink = carriable_object.instantiate()
	drink.set_object_data(drink_resource, drink_stand_location)
