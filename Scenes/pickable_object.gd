extends RigidBody2D

var picked = false
var marker_node;
	

func _physics_process(delta):
	if picked:
		var player = marker_node.get_position()

func pick(marker):
	marker_node = marker
	picked = true
	print(picked)
