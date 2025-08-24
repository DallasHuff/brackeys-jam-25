extends Node2D
# class_name Floor
# Autoload - manages room layout

@export var room_scenes: Array[PackedScene]
@export var rooms: Dictionary[Vector2i, PackedScene] = {

}
@export var current_position: Vector2i = Vector2i(0, 0)


func _ready() -> void:
	# print("ready")
	generate_floor_layout()
	load_room(current_position)


func generate_floor_layout() -> void:
	# print("generate floor layout")
	rooms[Vector2i(0, 0)] = room_scenes[0]
	rooms[Vector2i(0, 1)] = room_scenes[1]


func load_room(room_position: Vector2i) -> void:
	# print("load room")
	self.add_child(rooms[room_position].instantiate())


func travel_to_room(direction: Direction.Enum) -> void:
	# print("travel to room")
	if is_instance_valid(rooms[current_position]):
		rooms[current_position].queue_free()

	current_position += direction_to_position(direction)
	load_room(current_position)
	

func direction_to_position(direction: Direction.Enum) -> Vector2i:
	match direction:
		Direction.Enum.UP:
			return Vector2i.UP
		Direction.Enum.RIGHT:
			return Vector2i.RIGHT
		Direction.Enum.DOWN:
			return Vector2i.DOWN
		Direction.Enum.LEFT:
			return Vector2i.LEFT
		_:
			return Vector2i.ZERO
