extends Area2D
class_name Door

enum door_direction {
	up,
	down,
	left,
	right
}

@export var my_direction: door_direction = door_direction.up

var my_room: Room

var opening: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	if get_parent() is Room:
		my_room = get_parent()
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)

func _process(delta: float) -> void:
	if check_for_player() and Input.is_action_just_pressed("interact"):
		if my_room:
			if my_room.check_if_door_can_open():
				open_door()
		else:
			open_door()

func check_for_player() -> bool:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is Player:
			return true
	return false

func open_door() -> void:
	opening = true
	animated_sprite_2d.play("open")


func _on_animated_sprite_2d_animation_finished() -> void:
	if opening:
		opening = false
		animated_sprite_2d.play("default")
		#idk do code to load the next area
