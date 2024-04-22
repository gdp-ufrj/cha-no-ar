extends CharacterBody2D

@onready var camera = $Camera

@export_category("variable")
@export var move_speed:float = 80

var has_drink_in_hand = false
var drink_in_hand: Resource
var is_talking : bool

@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var interaction_indicator = $interaction_indicator

func remove_player_speed():
	move_speed = 0

func _ready() -> void:
	State.set_player_reference(self)
	update_animation_parameters(starting_direction)
	
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	pass

func _on_dialogue_ended(_resource: DialogueResource):
	move_speed = 80
	is_talking = false
	interaction_indicator.visible = false
	if (has_drink_in_hand):
		has_drink_in_hand = false
		drink_in_hand = null

func _physics_process(_delta: float) -> void:
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
	
	velocity = input_direction * move_speed
	
	move_and_slide()
	
	await pick_new_state()
	
	
func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/TeaWalk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/TeaIdle/blend_position", move_input)
	
func pick_new_state():
	var movement_tree_branch : String
	var idle_tree_branch : String
	if (!has_drink_in_hand):
		movement_tree_branch = "Walk"
		idle_tree_branch = "Idle"
	else :
		movement_tree_branch = "TeaWalk"
		idle_tree_branch = "TeaIdle"
	
	if(velocity != Vector2.ZERO):
		state_machine.travel(movement_tree_branch)
	else:
		state_machine.travel(idle_tree_branch)
