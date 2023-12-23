extends Node2D

func _ready():
	State.varanda_seating_group = self
	State.spawn_npcs_varanda()
