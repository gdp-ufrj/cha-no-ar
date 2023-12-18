extends Control
@onready var pause_menu = $"../Pause/CenterContainer/PauseMenu"
@onready var main_menu = $"../CenterContainer/MainMenu"

func troca_visibilidade_teste(node_path):
	if is_instance_valid(main_menu):
		var container = get_node(node_path)
		main_menu.visible = !main_menu.visible
		container.visible = !container.visible
	else:
		var container = get_node(node_path)
		pause_menu.visible = !pause_menu.visible
		container.visible = !container.visible

func _unhandled_input(event):
	if is_instance_valid(pause_menu):
		if event.is_action_pressed("pause"):
			if $".".visible == true:
				pause_menu.visible = !pause_menu.visible
				$".".visible = !$".".visible
#	if is_instance_valid(main_menu):
#		if event.is_action_pressed("pause"):
#			main_menu.visible = !main_menu.visible
#			$"../MainMenu".visible = !$"../MainMenu".visible

func _on_fullscreen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func troca_visibilidade(node_path):
	var container = get_node(node_path)
	main_menu.visible = !main_menu.visible
	container.visible = !container.visible

func _on_voltar_opçoes_pressed():
	troca_visibilidade_teste(".")
