extends CharacterBody2D
class_name Player

const speed: float = 100
var zoom: float = 3
var apply_zoom: Vector2

const zoom_min: float = 2
const zoom_max: float = 5.0

#stuff for health bar
@onready var healthbar_1: ProgressBar = $Camera2D/hud/GridContainer/healthbar_1
@onready var healthbar_2: ProgressBar = $Camera2D/hud/GridContainer/healthbar_2
@onready var healthbar_3: ProgressBar = $Camera2D/hud/GridContainer/healthbar_3


@onready var gun_pivot: Node2D = $gun_pivot
@onready var cursor: Sprite2D = $cursor

@onready var camera: Camera2D = $Camera2D
@onready var hud: Control = $Camera2D/hud
@onready var player_animator: AnimatedSprite2D = $AnimatedSprite2D

@export var health: int = 99

var bullet = preload("res://entitys/bullet/bullet.tscn")


func _ready() -> void:
	pass 

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	
	var zoom_input: float = 0.0
	if Input.is_action_just_released("zoom_in"):
		zoom_input = 0.1
	elif Input.is_action_just_released("zoom_out"):
		zoom_input = -0.1
	zoom = clamp((zoom + zoom_input), zoom_min, zoom_max)
	apply_zoom = Vector2(zoom, zoom)
	camera.zoom = apply_zoom
	hud.scale = Vector2(1,1) / apply_zoom * 3
	
	
	var input_vect: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down").normalized()
	velocity = input_vect * speed 

	move_and_slide()
	
	gun_pivot.look_at(get_global_mouse_position())
	cursor.global_position = get_global_mouse_position()
	
	if cursor.position.x < 0:
		player_animator.scale.x = -1
	else:
		player_animator.scale.x = 1
	
	if Input.is_action_just_pressed("fire"):
		fire_gun()
		health -= 1
		print(health)
	
	set_health_bar()

func fire_gun() -> void:
	var new_bullet: Bullet = bullet.instantiate()
	new_bullet.target_pos = cursor.global_position
	new_bullet.inital_pos = global_position
	get_tree().current_scene.add_child(new_bullet)

func set_health_bar() -> void:
	healthbar_1.value = clamp(health, 0, 33)
	healthbar_2.value = clamp(health, 33, 66) - 33
	healthbar_3.value = clamp(health, 66, 99) - 66
