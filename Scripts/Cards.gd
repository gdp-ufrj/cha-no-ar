extends Button

func set_infos(drink_resource: Resource):
	$Label.text = drink_resource.Drink_Name
	if drink_resource.Drink_Image:
		$Sprite2D.texture = load(drink_resource.Drink_Image)
