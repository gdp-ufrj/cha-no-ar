extends Node2D

func _ready():
	State.cafe_seating_group = self
	State.spawn_npcs_cafe()
