extends Control
@onready var pause_menu = $"../Pause/CenterContainer/PauseMenu"
@onready var main_menu = $"../CenterContainer/MainMenu"
@onready var vol_slider_master = $VBoxContainer/VolSliderMaster
@onready var vol_slider_sfx = $VBoxContainer/VolSliderSFX
@onready var vol_slider_music = $VBoxContainer/VolSliderMusic

var bus_master = AudioServer.get_bus_index("Master")
var bus_sfx = AudioServer.get_bus_index("sfx")
var bus_music = AudioServer.get_bus_index("music")

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
	toca_som_botao()
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
	toca_som_botao()
#####################Som
func _ready():
	vol_slider_master.value = AudioServer.get_bus_volume_db(bus_master)
	vol_slider_sfx.value = AudioServer.get_bus_volume_db(bus_sfx)
	vol_slider_music.value = AudioServer.get_bus_volume_db(bus_music)

func _on_vol_slider_master_value_changed(value):
	AudioServer.set_bus_volume_db(bus_master, value)
	AudioServer.set_bus_mute(bus_master, value == vol_slider_master.min_value)

func _on_vol_slider_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(bus_sfx, value)
	AudioServer.set_bus_mute(bus_sfx, value == vol_slider_sfx.min_value)

func _on_vol_slider_music_value_changed(value):
	AudioServer.set_bus_volume_db(bus_music, value)
	AudioServer.set_bus_mute(bus_music, value == vol_slider_music.min_value)

func toca_som_botao():
	$ButtonSound.play()
