extends Node2D
# class_name Floor
# Autoload - manages room layout

@export var room_scenes: Array[PackedScene] # Will be used as a pool of possible rooms once we start randomizing them
@export var rooms: Dictionary[Vector2i, PackedScene]
@export var current_position: Vector2i = Vector2i(0, 0)

var current_room: Room


func _ready() -> void:
	# print("ready")
	# generate_floor_layout()
	load_room(current_position)


func generate_floor_layout() -> void:
	# print("generate floor layout")
	rooms[Vector2i(0, 0)] = room_scenes[0]
	rooms[Vector2i(0, 1)] = room_scenes[0]


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

	current_position += direction_to_position(direction)
	load_room(current_position)
	

func is_room_in_direction(direction: Direction.Enum) -> bool:
	if rooms.has(current_position + direction_to_position(direction)):
		return true
	return false


func direction_to_position(direction: Direction.Enum) -> Vector2i:
	match direction:
		Direction.Enum.UP:
			return Vector2i.DOWN # flipped in y direction
		Direction.Enum.RIGHT:
			return Vector2i.RIGHT
		Direction.Enum.DOWN:
			return Vector2i.UP # flipped in y direction
		Direction.Enum.LEFT:
			return Vector2i.LEFT
		_:
			return Vector2i.ZERO
