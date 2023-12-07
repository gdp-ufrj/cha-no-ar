extends CharacterBody2D
var _state_machine

@onready var camera = get_node("Camera2D")

@export_category("variable")
@export var _move_speed:float =128

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

@onready var detector: Area2D = $direcao/Area2D

func _ready() -> void:
	_state_machine = _animation_tree["parameters/playback"]
	pass
	
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var acionaveis = detector.get_overlapping_areas()
		if acionaveis.size()>0:
			var interacting = acionaveis[0]
			if interacting.type == "Door":
				get_parent().go_to_scene(interacting.portal)
			elif interacting.type == "Dialogue":
				interacting.start_dialogue()
			elif interacting.type == "Carry":
				interacting.pick(get_node("ItemSpot"))
			return
		
func _physics_process(_delta: float) -> void:
	_move()
	_animated()
	move_and_slide()
	
func _move() -> void:
	var _direction:Vector2 = Vector2(
		Input.get_axis("ui_left","ui_right"),
		Input.get_axis("ui_up","ui_down")
	)
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction
	velocity = _direction.normalized()*_move_speed

func _animated() -> void:
	if velocity.length()>1:
		_state_machine.travel("walk")
		return
	_state_machine.travel("idle")

func make_player_current_camera():
	var tilemap = get_owner().get_node("Terreno")
	var map_rect = tilemap.get_used_rect()
	var cell_size = tilemap.cell_quadrant_size
	
	var map_size = map_rect.size * cell_size
	camera.limit_right = map_size.x
	camera.limit_bottom = map_size.y
