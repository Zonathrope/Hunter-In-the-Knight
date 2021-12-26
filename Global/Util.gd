class_name Util


static func get_opposite_direction(direction: int) -> int:
	match direction:
		Direction.UP:
			return Direction.DOWN
		Direction.DOWN:
			return Direction.UP
		Direction.LEFT:
			return Direction.RIGHT
		_:
			return Direction.LEFT

static func is_direction_vertical(direction: int) -> bool:
	return direction in [Direction.UP, Direction.DOWN]

static func get_rect_shape2d_size(shape: CollisionShape2D) -> Vector2:
	return shape.shape.extents * 2

static func get_true_with_chance(chance: float) -> bool:
	var random_number = randf()
	return random_number <= chance

static func choose_random_item(array: Array):
	return array[randi() % array.size()]

#including max and min
static func rand_int_between(minimal: int, maximal: int) -> int:
	return minimal + (randi() % (maximal - minimal + 1))
