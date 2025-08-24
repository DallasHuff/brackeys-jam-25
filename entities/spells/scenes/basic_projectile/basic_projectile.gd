extends Node2D

var direction: Vector2
var speed: float = 1000

@onready var hitbox: HitboxComponent = %HitboxComponent


func _ready() -> void:
	hitbox.hit.connect(_on_hit)
	

func _process(delta: float) -> void:
	global_position += direction.normalized() * speed * delta


func _on_hit() -> void:
	print("bp hit")
	queue_free()
