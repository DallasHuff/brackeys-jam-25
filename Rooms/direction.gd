class_name Direction

enum Enum {
	UP,
	RIGHT,
	DOWN,
	LEFT
}

static func direction_to_position(direction: Direction.Enum) -> Vector2i:
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

static func opposite(direction: Direction.Enum) -> Direction.Enum:
	match direction:
		Direction.Enum.UP:
			return Enum.DOWN
		Direction.Enum.RIGHT:
			return Enum.LEFT
		Direction.Enum.DOWN:
			return Enum.UP
		Direction.Enum.LEFT:
			return Enum.RIGHT
		_:
			return Enum.UP # never reached