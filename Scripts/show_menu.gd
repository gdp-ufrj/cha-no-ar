extends Node2D


@onready var open_book = false
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if !open_book:
			open_book = true
			$Recipes2.visible = true
		else:
			if Input.is_action_just_pressed("ui_accept"):
				open_book = false
				$Recipes2.visible = false
	
