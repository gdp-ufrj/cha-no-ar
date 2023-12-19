extends Node

var teste = "AAAA"

var player_instance = load("res://Scenes/Bodies/player.tscn").instantiate()
var player

var maps = {}
var current_scene

@onready var luz_ambiente = $LuzAmbiente
@onready var valores_luz_ambiente = [Color(0, 0.26, 0.34, 1), Color(0, 0, 0, 1),
									Color(0.28, 0.37, 0.26, 1), Color(0.58, 0.58, 0.58, 1)];

# Called when the node enters the scene tree for the first time.
func _ready():
	luz_ambiente.set_energy(1.4)
	luz_ambiente.set_color(valores_luz_ambiente[0])
	
	var quarto = load("res://Scenes/Mapas/quarto.tscn").instantiate()
	maps["quarto"] = quarto
	var cafe = load("res://Scenes/Mapas/cafe.tscn").instantiate()
	maps["cafe"] = cafe
	var ap = load("res://Scenes/Mapas/apartamento.tscn").instantiate()
	maps["apartamento"] = ap
	var varanda = load("res://Scenes/Mapas/varanda.tscn").instantiate()
	maps["varanda"] = varanda
	start_game()


##### INICIALIZACAO
func start_game():
	self.add_child(player_instance)
	player = get_node("Player")
	go_to_scene("quarto", 1)

func go_to_scene(nome, portal_num):
	if current_scene:
		self.remove_child(current_scene)
	
	self.add_child(maps.get(nome))
	current_scene = get_node(nome)
	print("Vou pra cena: " + str(current_scene))
	
	position_player(portal_num)

func position_player(portal_num):
	print("Spawn-" + str(portal_num))
	player.global_position = current_scene.get_node("Spawn-" + str(portal_num)).global_position
	player.z_index = 2


##### INTERACAO
func _on_time_pressed(index):
	luz_ambiente.set_color(valores_luz_ambiente[index])
	if index in[2, 3]:
		current_scene.get_node("LuzesFocais").visible = true
	else:
		current_scene.get_node("LuzesFocais").visible = false
		
