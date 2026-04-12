extends CharacterBody2D
class_name Player

const speed: float = 100
var zoom: float = 1

const zoom_min: float = 0.9
const zoom_max: float = 2.0

@onready var gun_pivot: Node2D = $gun_pivot
@onready var cursor: Sprite2D = $cursor

@onready var camera: Camera2D = $Camera2D

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
	camera.zoom.x = zoom
	camera.zoom.y = zoom
	
	
	var input_vect: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down").normalized()
	velocity = input_vect * speed 

	move_and_slide()
	
	gun_pivot.look_at(get_global_mouse_position())
	cursor.global_position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("fire"):
		fire_gun()

func fire_gun() -> void:
	var new_bullet: Bullet = bullet.instantiate()
	new_bullet.target_pos = cursor.global_position
	new_bullet.inital_pos = global_position
	get_tree().current_scene.add_child(new_bullet)
