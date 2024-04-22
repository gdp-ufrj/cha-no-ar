extends Area2D

@export var interactor : Node2D
@export var interaction_action : StringName = "interact"

@onready var player_reference = $".."
@onready var animation_player = $"../AnimationPlayer"
@onready var interaction_indicator = $"../interaction_indicator"

var selected_interactable : Interactable
var nearby_interactables : Array[Interactable]

var is_interacting : bool = false

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

@onready var scene_manager = State.get_scene_manager()

func _input(event : InputEvent):
	if (is_interacting):
		return
	if (event.is_action_pressed(interaction_action) and !player_reference.is_talking):
		if (selected_interactable != null):
			if (selected_interactable.type == "Door"):
				scene_manager.go_to_scene(selected_interactable.portal, selected_interactable.number)
			elif (selected_interactable.type == "Dialogue" or selected_interactable.type == "Seat"):
				player_reference.is_talking = true
				player_reference.remove_player_speed()
				selected_interactable.start_dialogue()
			elif (selected_interactable.type == "Counter"):
				selected_interactable.recipe_book.visible = true
			else:
				selected_interactable.interact()

func _on_area_entered(area):
	if(area is Interactable):
		print_debug(area)
		if (area.type == "Seat" and !area.taken):
			return
		interaction_indicator.visible = true
		nearby_interactables.push_back(area)
		
		if(selected_interactable == null):
			selected_interactable = nearby_interactables[0]

func _on_area_exited(area):
	interaction_indicator.visible = false
		
	nearby_interactables.erase(area)
		
	if(nearby_interactables.size() > 0):
		selected_interactable = nearby_interactables[0]
	else:
		selected_interactable = null
		
