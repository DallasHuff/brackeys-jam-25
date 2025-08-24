class_name HitboxComponent
extends Area2D

signal hit

@export var damage: float
@export var healing: float


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: HurtboxComponent) -> void:
	if damage > 0:
		body.take_damage(damage)
		hit.emit()

	if healing > 0:
		body.take_healing(healing)
		hit.emit()
