extends Area2D

var mouse_position
onready var sprite_left = $AttackSprite_left
onready var sprite_right = $AttackSprite_right
var flipped = false

func _ready():
	sprite_right.flip_v = true
	change_sword()

func _process(delta):
	change_sword()

func change_sword():
	mouse_position = - get_local_mouse_position()
	rotation += mouse_position.angle()
	if(get_parent().get_local_mouse_position().x >= 0 && !flipped):
		sprite_left.visible = false
		sprite_right.visible = true
		flipped = true
	elif(get_parent().get_local_mouse_position().x < 0 && flipped):
		sprite_left.visible = true
		sprite_right.visible = false
		flipped = false
