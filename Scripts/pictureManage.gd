extends Sprite2D

<<<<<<< Updated upstream
var emote = preload("res://Scripts/state.gd").new()
#var iconFeliz = preload("res://Temporario/kirbyFeliz.png")

#var emocao: int = 0
# Called when the node enters the scene tree for the first time.
var emocao_count = emote.getEmocao()
func _ready():
	print(emote.getEmocao())
	pass
func changePicuture():
	if emocao_count == 0:
		print("cai no 1 if")
	if  emocao_count == 1:
		print("cai no 2 if")
=======
#var iconPadrão = preload("res://Temporario/kirbyNormal.png")
#var iconFeliz = preload("res://Temporario/kirbyFelizResized.png")
#var iconTriste = preload("res://Temporario/kirbyTristeResized.png")
@onready var moldura_player = $"."
#var emocao: int = 0
# Called when the node enters the scene tree for the first time.

func _process(_delta):
	changePicture()

func changePicture():
	if State.estado["emocao_count"] == 0:
		moldura_player.texture = load("res://Temporario/iris_normal.png")
	if State.estado["emocao_count"] == 1:
		moldura_player.texture = load("res://Temporario/kirbyFelizResized.png")
	if  State.estado["emocao_count"] == 2:
		moldura_player.texture = load("res://Temporario/iris_triste.png")
>>>>>>> Stashed changes
