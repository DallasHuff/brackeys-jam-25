extends Node

var bias_power: float = 1.3 # > 0, larger = stronger anti-clumping
var floor_seed: int = -1 # -1 = random seed; else set for deterministic results

const DIRECTIONS := [Vector2i.RIGHT, Vector2i.LEFT, Vector2i.UP, Vector2i.DOWN]

func generate(number_of_rooms: int) -> Array[Vector2i]:
	var rooms: Array[Vector2i] = [Vector2i.ZERO] # start at (0,0)
	var random_generator := RandomNumberGenerator.new()
	if floor_seed >= 0:
		random_generator.seed = floor_seed
	else:
		random_generator.randomize()
	while rooms.size() < number_of_rooms:
		var frontier_positions := _compute_frontier(rooms)
		# Build weights: w = 1 / (adjacent_count ^ bias_power)
		var weights := PackedFloat32Array()
		weights.resize(frontier_positions.size())
		var total_weight: float = 0.0
		for i in frontier_positions.size():
			var candidate_position: Vector2i = frontier_positions[i]
			var adjacent_count: int = _adjacent_count(candidate_position, rooms)
			var weight: float = 1.0 / pow(float(adjacent_count), bias_power)
			weights[i] = weight
			total_weight += weight
		# Roulette selection
		var random_threshold: float = random_generator.randf() * total_weight
		var accumulated_weight: float = 0.0
		var chosen_position: Vector2i = frontier_positions[0]
		for i in frontier_positions.size():
			accumulated_weight += weights[i]
			if random_threshold <= accumulated_weight:
				chosen_position = frontier_positions[i]
				break
		rooms.append(chosen_position)
	print_generation(rooms)

	return rooms


func _compute_frontier(rooms: Array[Vector2i]) -> Array[Vector2i]:
	# All empty 4-neighbors (or 8 if you extended DIRECTIONS) of current rooms, unique
	var frontier: Array[Vector2i] = []
	for existing_room in rooms:
		for direction: Direction.Enum in Direction.Enum.values():
			var neighbor_position: Vector2i = existing_room + Direction.direction_to_position(direction)
			if not rooms.has(neighbor_position) and not frontier.has(neighbor_position):
				frontier.append(neighbor_position)
	return frontier


func _adjacent_count(candidate_position: Vector2i, rooms: Array[Vector2i]) -> int:
	var count: int = 0
	for direction: Direction.Enum in Direction.Enum.values():
		if rooms.has(candidate_position + Direction.direction_to_position(direction)):
			count += 1
	return count


func print_generation(rooms: Array[Vector2i]) -> void:
	if rooms.is_empty():
		print("No rooms to display")
		return

	# Find bounds of the grid
	var min_x: int = rooms[0].x
	var max_x: int = rooms[0].x
	var min_y: int = rooms[0].y
	var max_y: int = rooms[0].y
	for room in rooms:
		min_x = min(min_x, room.x)
		max_x = max(max_x, room.x)
		min_y = min(min_y, room.y)
		max_y = max(max_y, room.y)

	# Build grid line by line (print with y increasing upwards)
	for y in range(max_y, min_y - 1, -1): # from top row down
		var line := ""
		for x in range(min_x, max_x + 1):
			var pos := Vector2i(x, y)
			if pos == Vector2i.ZERO:
				line += "■"  # Mark the starting room
			elif rooms.has(pos):
				line += "□"
			else:
				line += "."
		print(line)
