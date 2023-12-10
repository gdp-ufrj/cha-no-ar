extends Control

var scene_manager = "res://Scenes/sceneManager.tscn"
@onready var main_menu = get_node("CenterContainer/MainMenu")

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_window().borderless = true
	get_window().min_size = Vector2i(960, 540)
	if State.save_exists():
		get_node("CenterContainer/MainMenu/Continuar").disabled = false

func _on_jogar_pressed():
	if State.save_exists():
		troca_visibilidade("CenterContainer/Aviso")
	else:
		get_tree().change_scene_to_file(scene_manager)

func _on_continuar_pressed():
	State.load_data()
	get_tree().change_scene_to_file(scene_manager)

func _on_aceitar_pressed():
	State.save_game()
	get_tree().change_scene_to_file(scene_manager)

func troca_visibilidade(node_path):
	var container = get_node(node_path)
	main_menu.visible = !main_menu.visible
	container.visible = !container.visible


##### OPCOES
func _on_fullscreen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)



##### SAIR DO JOGO
func _on_sair_pressed():
	get_tree().quit()

