extends Control
@onready var creditos = Container.new()
@onready var main_menu = Container.new()
@onready var opçoes = Container.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	get_window().min_size = Vector2i(960, 540)
	creditos.visible = false

func _on_jogar_pressed():
	get_tree().change_scene_to_file("res://Scenes/sceneManager.tscn")



func _on_opções_pressed():
	main_menu = get_node("CenterContainer/MainMenu")
	main_menu.visible = false
	opçoes = get_node("CenterContainer/Opções")
	opçoes.visible = true


func _on_créditos_pressed():
	main_menu = get_node("CenterContainer/MainMenu")
	main_menu.visible = false
	creditos = get_node("Creditos")
	creditos.visible = true
#	pause_menu = get_node("CenterContainer/VBoxContainer")
#	pause_menu.visible = false


func _on_sair_pressed():
	get_tree().quit()


func _on_voltar_creditos_pressed():
	creditos.visible = false
	main_menu.visible = true


func _on_voltar_opçoes_pressed():
	opçoes.visible = false
	main_menu.visible = true
