extends Node
var index = -1
var rng = RandomNumberGenerator.new()
var random_number_seat
var random_number_npc
var npc_image
var npc_image_from_resource
var npc_escolhido = false
#Posições
var position_0_x= 0
var position_0_y= 30
#######NPCS
var npc_1 = load("res://Resources/NPCS/NPC_1.tres")
var npc_2 = load("res://Resources/NPCS/NPC_2.tres")
var npc_3 = load("res://Resources/NPCS/NPC_3.tres")
var npc_4 = load("res://Resources/NPCS/NPC_4.tres")
var npc_5 = load("res://Resources/NPCS/NPC_5.tres")
var npc_6 = load("res://Resources/NPCS/NPC_6.tres")
var npc_7 = load("res://Resources/NPCS/NPC_7.tres")
var npc_8 = load("res://Resources/NPCS/NPC_8.tres")
var npc_array = [npc_1,npc_2,npc_3,npc_4,npc_5,npc_6,npc_7,npc_8]
#########Seats (poderia ser bem melhor feito mas fiz do jeito mais simples possível
var seats:= [false,true,true, true,true, true, true, true, true, true, true, false]
func _ready():
	_checa_assento(npc_array)
func _checa_assento(npc_array):
	while npc_escolhido == false:
			random_number_seat = round(rng.randf_range(0,11))
			print(random_number_seat)
			if seats[random_number_seat] == false:
				seats[random_number_seat] = true
				##Pra o spawn de npcs não ser sempre na mesma ordem, tem esse random
				##Pra fazer com quem seja aleatório qual dos 8 npcs vai spawnar
				random_number_npc = round(rng.randf_range(0,7))
				npc_image = Sprite2D.new()
				npc_image_from_resource = npc_array[random_number_npc].NPC_Image
				npc_image.texture = load(npc_image_from_resource)
				add_child(npc_image)
				npc_escolhido = true
				$".".global_position.y = position_0_y
