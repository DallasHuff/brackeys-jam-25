class_name Player
extends Node2D

@export var health_component: HealthComponent
@export var move_component: MoveComponent
@export var spell_component: SpellComponent


func _ready() -> void:
	health_component.died.connect(_on_died)


func move_input(dir: Vector2) -> void:
	if dir == Vector2.ZERO:
		return
	move_component.move_in_direction(dir)


func cast(dir: Vector2) -> void:
	spell_component.cast_spell(dir, self)


func get_health_component() -> HealthComponent:	
	return health_component
	

func _on_died() -> void:
	print("player died!!!!!!")
