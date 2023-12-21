extends Node
var index = -1
var rng = RandomNumberGenerator.new()
var random_number
var npc_image
var npc_image_from_resource
#Posições
var position_0_x= 0
var position_0_y= 30
@export var _NPC: NPC_Resource
var seats:= [false,false,false, false,false, false, false, false, false, false, false, false]
func _ready():
	_checa_assento(_NPC)
func _checa_assento(_NPC):	
	for x in seats:
			random_number = round(rng.randf_range(0,11))
			print(random_number)
			if seats[random_number] == false:
				seats[random_number] = true
				npc_image = Sprite2D.new()
				npc_image_from_resource = _NPC.NPC_Image
				npc_image.texture = load(npc_image_from_resource)
				add_child(npc_image)
				$".".global_position.y = position_0_y
