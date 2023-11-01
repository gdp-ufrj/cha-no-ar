extends Node2D

@onready var luz_ambiente = $LuzAmbiente
@onready var valores_luz_ambiente = [Color(0, 0.26, 0.34, 1), Color(0, 0, 0, 1),
									Color(0.28, 0.37, 0.26, 1), Color(0.58, 0.58, 0.58, 1)];

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_window().borderless = true
	get_window().min_size = Vector2i(1280, 720)
	luz_ambiente.set_energy(1.4)
	luz_ambiente.set_color(valores_luz_ambiente[0])

func _on_time_pressed(index):
	luz_ambiente.set_color(valores_luz_ambiente[index])
	if index in[2, 3]:
		get_node("LuzPontual").visible = true
	else:
		get_node("LuzPontual").visible = false
