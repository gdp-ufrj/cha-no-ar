extends Sprite2D

var iconPadrão = preload("res://Temporario/kirbyNormal.png")
var iconFeliz = preload("res://Temporario/kirbyFelizResized.png")
var iconTriste = preload("res://Temporario/kirbyTristeResized.png")
@onready var moldura_player = $"."
#var emocao: int = 0
# Called when the node enters the scene tree for the first time.

func _process(delta):
	changePicuture()
func changePicuture():
	if State.emocao_count == 0:
		moldura_player.texture = iconPadrão
	if State.emocao_count == 1:
		moldura_player.texture = iconFeliz
	if  State.emocao_count == 2:
		moldura_player.texture = iconTriste
