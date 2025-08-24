class_name SpellComponent
extends Node

@export var active_spell: Spell
var ready_to_cast := true


func cast_spell(dir: Vector2, character: Node2D) -> void:
	if not ready_to_cast:
		return
	active_spell.cast(dir, character)
	ready_to_cast = false
	get_tree().create_timer(active_spell.cooldown, false).timeout.connect(func() -> void: ready_to_cast = true)
