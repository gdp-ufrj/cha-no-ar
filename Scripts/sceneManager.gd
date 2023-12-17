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
	print_tree()
	var quarto = load("res://Scenes/fase.tscn").instantiate()
	maps["fase"] = quarto
	var cafe = load("res://Scenes/cafe.tscn").instantiate()
	maps["cafe"] = cafe
	start_game()


##### INICIALIZACAO
func start_game():
	self.add_child(player_instance)
	player = get_node("Player")
	go_to_scene("fase")

func go_to_scene(nome):
	print(State.capuccino_count)
	if current_scene:
		self.remove_child(current_scene)
	
	self.add_child(maps.get(nome))
	current_scene = get_node(nome)
	print("Vou pra cena: " + str(current_scene))
	
	position_player()

func position_player():
	player.global_position = current_scene.get_node("Spawn").global_position
	player.z_index = 2


##### INTERACAO
func _on_time_pressed(index):
	luz_ambiente.set_color(valores_luz_ambiente[index])
	if index in[2, 3]:
		current_scene.get_node("LuzesFocais").visible = true
	else:
		current_scene.get_node("LuzesFocais").visible = false
		
