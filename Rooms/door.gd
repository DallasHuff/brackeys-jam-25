class_name Door
extends Area2D

@export var travelDirection: Direction.Enum = Direction.Enum.UP
@export var spawnPoint: Node2D
@onready var room: Room = get_parent() as Room

var enabled: bool = false

func _ready() -> void: 
	body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node2D) -> void:
	if enabled:
		Floor.travel_to_room(travelDirection)
