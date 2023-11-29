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

func _on_cha_amarelo_pressed():
	cha_amarelo.global_position = Vector2(65,116)
	cha_amarelo.visible = true
	receitas.visible = false
	aberto = false
func _on_cha_azul_pressed():
	print("Cha Azul vish")
