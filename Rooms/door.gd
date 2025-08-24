class_name Door
extends Area2D

@export var travelDirection: Direction.Enum = Direction.Enum.UP

@onready var room: Room = get_parent() as Room

func _ready() -> void: 
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Floor.travel_to_room(travelDirection)
