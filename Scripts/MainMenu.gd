extends Control
@onready var checaOrigem: int
var volume: float
var scene_manager = "res://Scenes/sceneManager.tscn"
@onready var main_menu = get_node("CenterContainer/MainMenu")

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_window().borderless = true
	get_window().min_size = Vector2i(960, 540)
	if State.save_exists():
		get_node("CenterContainer/MainMenu/Continuar").disabled = false

func _on_jogar_pressed():
	toca_som_botao()
	if State.save_exists():
		troca_visibilidade("Aviso")
	else:
		get_tree().change_scene_to_file(scene_manager)

func _on_continuar_pressed():
	toca_som_botao()
	State.load_data()
	get_tree().change_scene_to_file(scene_manager)

func _on_aceitar_pressed():
	toca_som_botao()
	State.save_game()
	get_tree().change_scene_to_file(scene_manager)

func troca_visibilidade(node_path):
	var container = get_node(node_path)
	main_menu.visible = !main_menu.visible
	container.visible = !container.visible

##### OPCOES
func _on_fullscreen_toggled(button_pressed):
	toca_som_botao()
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

##### SAIR DO JOGO
func _on_sair_pressed():
	get_tree().quit()
#############Trocas de visibilidade
func _on_voltar_pressed():
	toca_som_botao2()
	troca_visibilidade("Aviso")
func _on_créditos_pressed():
	toca_som_botao2()
	_teste_dictionary()
	troca_visibilidade("Créditos")
func _on_voltar_creditos_pressed():
	toca_som_botao()
	troca_visibilidade("Créditos")
###### Audio Settings
func _on_volume_musica_drag_ended(_value_changed):
	volume =  $"CenterContainer/Opções/VolumeMusica".value
	$BackgroundMusic.volume_db = volume

func _on_volume_geral_drag_ended(_value_changed):
	volume = get_node("CenterContainer/Opções/VolumeGeral").value
	get_node("BackgroundMusic").volume_db = volume
func toca_som_botao():
	$ButtonSound.play()

func toca_som_botao2():
	$ButtonSound2.play()

func _on_opções_pressed():
	troca_visibilidade("Ajustes")
	toca_som_botao2()
