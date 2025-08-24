class_name HealthComponent
extends Node

signal died
signal took_damage(amount: float)
signal took_healing(amount: float)

@export var max_health: float
var current_health: float
var dead: bool


func _ready() -> void:
	current_health = max_health


func take_damage(damage: float) -> void:
	current_health -= damage
	if current_health <= 0:
		died.emit()
		dead = true


func take_healing(healing: float) -> void:
	var previous := current_health
	current_health = clampf(current_health + healing, -1, max_health)
	if current_health - previous > 0.1:
		took_healing.emit(current_health - previous)
