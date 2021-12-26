extends Camera2D

var target_location = Vector2()

export var camera_offset_range = 0.2
export var camera_offset_speed = 0.4

func _process(delta):
	var center = get_viewport_rect().size / 2
	target_location = center.linear_interpolate(get_viewport().get_mouse_position(), camera_offset_range) - center
	pass

func _physics_process(delta):
	var pos = position.linear_interpolate(target_location, camera_offset_speed)
	if(abs(pos.x) > 1.5 || abs(pos.y) > 1.5):
		position = position.linear_interpolate(target_location, camera_offset_speed)
	pass
