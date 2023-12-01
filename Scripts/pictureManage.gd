extends Sprite2D

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
