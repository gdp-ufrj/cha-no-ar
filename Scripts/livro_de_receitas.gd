extends Control
@onready var receitas = $"."
var aberto = false
var cha_amarelo = preload("res://Scenes/cha_amarelo.tscn")
#@onready var background_image = $BackgroundImage
#
func _unhandled_input(event):
	if event.is_action_pressed("receitas"):
		if aberto == false:
			receitas.visible = true
			aberto = true
		else:
			aberto = false
			receitas.visible = false

func _on_cha_amarelo_pressed():
	self.add_child(cha_amarelo)
func _on_cha_azul_pressed():
	print("Cha Azul vish")
