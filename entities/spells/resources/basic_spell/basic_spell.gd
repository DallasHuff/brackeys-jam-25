extends Spell
"""
Basic projectile
"""

@export var spell_scene: PackedScene


func cast(dir: Vector2, character: Node2D) -> void:
	var proj: Node2D = spell_scene.instantiate()
	proj.direction = dir
	character.get_tree().root.add_child(proj)
	proj.global_position = character.global_position
