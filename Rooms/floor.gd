extends Node2D
# class_name Floor
# Autoload - manages room layout

@export var room_scenes: Array[PackedScene] # Will be used as a pool of possible rooms once we start randomizing them
@export var number_of_rooms: int = 10
@export var current_position: Vector2i = Vector2i(0, 0)

var rooms: Dictionary[Vector2i, PackedScene]
var current_room: Room


func _ready() -> void:
	# print("ready")
	setup_room_layout()
	load_room(current_position)


func setup_room_layout() -> void:
	for room in GenerateRoomLayout.generate(number_of_rooms):
		rooms[room] = room_scenes[0]


func load_room(room_position: Vector2i) -> void:
	# print("load room")
	current_room = rooms[room_position].instantiate()
	current_room.initialize_doors(
		is_room_in_direction(Direction.Enum.UP), 
		is_room_in_direction(Direction.Enum.RIGHT), 
		is_room_in_direction(Direction.Enum.DOWN), 
		is_room_in_direction(Direction.Enum.LEFT)
	)
	self.add_child(current_room)


func travel_to_room(direction: Direction.Enum) -> void:
	# print("travel to room")
	if is_instance_valid(rooms[current_position]):
		current_room.queue_free()

	current_position += Direction.direction_to_position(direction)
	load_room(current_position)
	

func is_room_in_direction(direction: Direction.Enum) -> bool:
	if rooms.has(current_position + Direction.direction_to_position(direction)):
		return true
	return false
