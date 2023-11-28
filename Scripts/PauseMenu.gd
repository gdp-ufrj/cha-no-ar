extends Control
@onready var ajuda = Container.new()
@onready var pause_menu = Container.new()
func _unhandled_input(event):
	#Ao apertar o input relacionado com o evento pause(nesse caso o Esc) muda o valor de is_paused pro valor
	#contrário, ou seja, se não tiver aberto, abre, se tiver aberto, fecha.
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused
		if ajuda.visible == true:
			pause_menu.visible = true
			ajuda.visible = false
			
#Basicamente, se o valor de is paused for true = mostra o menu, despausa o menu e pausa
#todo mundo da arvore de cima
var is_paused = false : 
	set(value):
		is_paused = value
		get_tree().paused = is_paused
		visible = is_paused
#Resume
func _on_resume_button_pressed():
	self.is_paused = false
	
#Apertou no botão: quitou do jogo uhu
func _on_quit_button_pressed():
	get_tree().quit()
func _on_ajuda_pressed():
	ajuda = get_node("CenterContainer/Ajuda2")
	ajuda.visible = true
	pause_menu = get_node("CenterContainer/VBoxContainer")
	pause_menu.visible = false

func _on_voltar_pressed():
	pause_menu.visible = true
	ajuda.visible = false

func _on_menu_principal_pressed():
	is_paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
