extends Node

var player_instance = load("res://Scenes/Bodies/player.tscn").instantiate()
var player

@onready var pausa_dialogo = $"Pausa-Dialogo"

var maps = {}
var current_scene

@onready var luz_ambiente = $LuzAmbiente
@onready var valores_luz_ambiente = [Color(0, 0.26, 0.34, 1), Color(0, 0, 0, 1),
									Color(0.28, 0.37, 0.26, 1), Color(0.58, 0.58, 0.58, 1)];

	
# Called when the node enters the scene tree for the first time.
func _ready():
#	luz_ambiente.set_energy(1.4)
#	luz_ambiente.set_color(valores_luz_ambiente[0])
	State.set_scene_manager(self)
	var quarto = load("res://Scenes/Mapas/quarto.tscn")
	maps["quarto"] = quarto
	var cafe = load("res://Scenes/Mapas/cafe.tscn")
	maps["cafe"] = cafe
	var ap = load("res://Scenes/Mapas/apartamento.tscn")
	maps["apartamento"] = ap
	var varanda = load("res://Scenes/Mapas/varanda.tscn")
	maps["varanda"] = varanda
	
	State.pausa_dialogue_changed.connect(change_pause_dialogue_visible)
	start_game()


func change_pause_dialogue_visible():
	pausa_dialogo.visible = State.pausa_dialogo

##### INICIALIZACAO
func start_game():
	self.add_child(player_instance)
	player = get_node("Player")
	
	State.restart_game_state()
	
	go_to_scene("quarto", 1)
	State.assign_all_day_NPCs()

func go_to_scene(nome, portal_num):
	if current_scene:
		current_scene.queue_free()
	
	var scene_instance = maps.get(nome).instantiate()
	
	self.add_child(scene_instance)
	
	current_scene = get_node(nome)
	current_scene.get_node("Camera").make_current()
	
	if nome == "cafe":
		State.spawn_npcs_cafe()
		
	if nome == "varanda":
		State.spawn_npcs_varanda()
	
	position_player(portal_num)

func position_player(portal_num):
	print("Spawn-" + str(portal_num))
	player.global_position = current_scene.get_node("Spawn-" + str(portal_num)).global_position
	player.z_index = 2
