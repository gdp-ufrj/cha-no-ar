extends Node

var current_scene = "fase"
var transition_scene = false
@onready var player = get_node("Player")
var talking_to
var drink_resource: Resource

var held_drink_tags: Array

var capuccino_count: int = 1
var emocao_count: int = 0

var comparation: int = 0
	
func compare_tags(tags_asked: Array):
	var score = 0
	for asked in tags_asked:
		for delivered in held_drink_tags:
			if delivered == asked:
				score = score + 1
	return score
		
	
	

func getEmocao():
	return emocao_count
