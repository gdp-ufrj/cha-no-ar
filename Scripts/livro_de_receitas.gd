extends Control
@onready var receitas = $"."
@onready var cha_amarelo = $"../../SpawnCha/CháAmarelo"
var aberto = false

func _unhandled_input(event):
	if event.is_action_pressed("receitas"):
		if aberto == false:
			receitas.visible = true
			aberto = true
		else:
			aberto = false
			receitas.visible = false
