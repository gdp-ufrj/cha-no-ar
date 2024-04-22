extends Interactable

@onready var recipes = $"../RecipeCanvas/Recipes"

func interact():
	print_debug("interag")
	recipes.toggle_recipe_book()

