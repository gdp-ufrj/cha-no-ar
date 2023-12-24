extends Area2D

@onready var recipe_book = get_node("/root/sceneManager/cafe/RecipeCanvas/Recipes")

func _input(_event):
	if Input.is_action_just_pressed("ui_interact"):
		var bodies = self.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player":
				recipe_book.toggle_recipe_book()


