class_name Spell
extends Resource

@export var spell_name: String
@export_multiline var description: String
@export var cooldown: float
@export var icon: Texture2D


func cast(cast_dir: Vector2, owner: Node2D) -> void:
	if owner and cast_dir:
		pass
