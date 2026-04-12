extends CharacterBody2D
class_name Enemy

@export_category("stats")
@export var health: int = 1
@export var speed: float = 1
#@export var weapon: WeaponData ##add if the enimy is ranged
@export var damage: int = 1 ##melee damage, unessicery if there is a gun
enum enemy_type_list {
	melee,
	ranged
}
@export var enemy_type: enemy_type_list = enemy_type_list.melee

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
