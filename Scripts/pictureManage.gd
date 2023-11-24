extends Sprite2D

var iconPadrao = preload("res://Temporario/kirbyNormal.png")
var iconFeliz = preload("res://Temporario/kirbyFeliz.png")
@onready var retrato = get_node("MolduraPlayer")
var emocao: int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func changePicuture():
	if emocao == 0:
		retrato.set_texture(iconPadrao)
	if emocao == 1:
		retrato.set_texture(iconFeliz)
