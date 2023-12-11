extends StaticBody2D

var picked = false

var player_marker
var player
var fase

var drink_resource: Resource

func _ready():
	player_marker = get_node("../../Player/Marker2D")
	player = get_node("../../Player")
	fase = get_parent()

func set_object_data(received_drink_resource: Resource, drink_spawn_location):
	drink_resource = received_drink_resource
	if received_drink_resource.Drink_Image:
		get_node("ObjectSprite").texture = load(received_drink_resource.Drink_Image)
	else:
		get_node("ObjectSprite").texture = load("res://Assets/sprites/ui/Chá.png")
	self.global_position = drink_spawn_location
	
func _input(event):
	if Input.is_action_just_pressed("ui_pick") and picked == false:
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and get_node("../../Player").can_pick == true:
				self.picked = true
				fase.remove_child(self)
				player_marker.add_child(self)
				self.position = Vector2(0,0)
				player.can_pick = false
				
	elif Input.is_action_just_pressed("ui_pick") and picked == true:
		picked = false
		player_marker.remove_child(self)
		self.global_position = player_marker.global_position
		fase.add_child(self)
		player.can_pick = true
	
