extends Node

@export var moldura : Sprite2D
@onready var state = load("res://Scripts/state.gd")
var emocao = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if emocao == 0:
		moldura.texture = load("res://Temporario/kirbyNormal.png")
	if emocao == 1:
		moldura.texture = load("res://Temporario/kirbyFeliz.png")
	if emocao == 2:
		pass
