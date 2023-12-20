extends StaticBody2D

@onready var recipe_book = get_node("/root/sceneManager/fase/CanvasLayer/Recipes")

func _input(_event):
	if Input.is_action_just_pressed("ui_interact"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player":
				recipe_book.toggle_recipe_book()
				
