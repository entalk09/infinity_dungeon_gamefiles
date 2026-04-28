extends Node2D
class_name Room

@export_category("enemys")
@export var enemy_pool: Array[EnemySpawnData]
@export var max_count: int = 1
@export var min_count: int = 0
var enemy_count: int = 0

@export_category("navigation")
@export var relative_coords: Vector2
@export var doors: Array[Door]



func _ready() -> void:
	pass

func check_if_door_can_open() -> bool:
	if enemy_count <= 0:
		return true
	else:
		return false

func door_opened(door_dir: Door.door_direction) -> void:
	match door_dir:
		Door.door_direction.up:
			pass
		Door.door_direction.down:
			pass
		Door.door_direction.left:
			pass
		Door.door_direction.right:
			pass
