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
