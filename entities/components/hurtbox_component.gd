class_name HurtboxComponent
extends Area2D

@export var health_component: HealthComponent


func take_damage(damage: float) -> void:
	health_component.take_damage(damage)


func take_healing(amount: float) -> void:
	health_component.take_healing(amount)
