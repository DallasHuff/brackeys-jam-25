extends Node2D
# class_name Floor
# Autoload - manages room layout

@export var room_scenes: Array[PackedScene] # Will be used as a pool of possible rooms once we start randomizing them
@export var number_of_rooms: int = 10
@export var current_position: Vector2i = Vector2i(0, 0)

var player: Player
var rooms: Dictionary[Vector2i, PackedScene]
var current_room: Room
var traveling: bool = false


func _ready() -> void:
	player = get_tree().get_root().find_child("Player", true, false)
	setup_room_layout()
	load_room(current_position, Direction.Enum.UP, true)


func setup_room_layout() -> void:
	for room in GenerateRoomLayout.generate(number_of_rooms):
		rooms[room] = room_scenes[0]
	# print("rooms:", rooms.keys())


func load_room(room_position: Vector2i, direction: Direction.Enum, initial_spawn: bool) -> void:
	player.move_component.locked = true
	current_room = rooms[room_position].instantiate()
	current_room.initialize_doors(
		is_room_in_direction(Direction.Enum.UP), 
		is_room_in_direction(Direction.Enum.RIGHT), 
		is_room_in_direction(Direction.Enum.DOWN), 
		is_room_in_direction(Direction.Enum.LEFT)
	)

	if !initial_spawn:
		player.position = current_room.get_spawn_point(direction)
	player.move_component.locked = false

	current_room.enable_doors()
	self.call_deferred("add_child", current_room)


func travel_to_room(direction: Direction.Enum) -> void:
	if traveling:
		return
	traveling = true

	if is_instance_valid(current_room):
		current_room.call_deferred("queue_free")

	current_position += Vector2i(Direction.direction_to_position(direction))
	load_room(current_position, Direction.opposite(direction), false)

	_finish_travel()


func _finish_travel() -> void:
	await get_tree().create_timer(0.1).timeout
	traveling = false
	

func is_room_in_direction(direction: Direction.Enum) -> bool:
	if rooms.has(current_position + Direction.direction_to_position(direction)):
		return true
	return false
