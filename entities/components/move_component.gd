class_name MoveComponent
extends Node

@export var character: CharacterBody2D
@export var speed: float = 1000


func move_in_direction(dir: Vector2) -> void:
	character.velocity = dir.normalized() * speed
	character.move_and_slide()


func move_toward_point(target_location: Vector2) -> void:
	character.velocity = (target_location - character.global_position).normalized() * speed
	character.move_and_slide()
