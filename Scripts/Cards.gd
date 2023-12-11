extends Button

var container: VBoxContainer
var drink_resource: Resource

func _ready():
	container = self.get_parent()
	button.pressed.connect(self.spawn_drink)

func set_infos(drink_resource: Resource):
	self.drink_resource = drink_resource
	self.text = drink_resource.Drink_Name
	if drink_resource.Drink_Image:
		self.icon = load(drink_resource.Drink_Image)
	else: 
		self.icon = load("res://Assets/sprites/ui/Chá.png")
		
func spawn_drink():
	
