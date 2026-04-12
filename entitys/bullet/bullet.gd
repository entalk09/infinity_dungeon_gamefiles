extends Node2D
class_name Bullet

var inital_pos: Vector2 = Vector2.ZERO
var target_pos: Vector2 = Vector2.ZERO
@export var range_limit: float = 999

@export var bullet_data: BulletData

var velocity: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = inital_pos
	velocity = position.direction_to(target_pos)
	if velocity == Vector2.ZERO:
		velocity = position.direction_to(Vector2(randf(),randf()))
	look_at(target_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * bullet_data.speed * delta

func despawn_bullet() -> void:
	damage_entity()
	queue_free()

func damage_entity() -> void:
	pass
	#code for applying damage to entity

func _on_area_2d_body_entered(body: Node2D) -> void:
	despawn_bullet()

func make_velocity(tar_position: Vector2) -> void:
	pass
	
