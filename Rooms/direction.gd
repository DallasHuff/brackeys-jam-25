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