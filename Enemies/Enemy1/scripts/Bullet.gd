extends Area2D

var move = Vector2.ZERO
var look_vec = Vector2.ZERO
var player = null
var speed = 3
var damage = 1

func _ready():
	look_vec = player


func _physics_process(delta):
	move = Vector2.ZERO
	
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * speed
	position += move



func _on_Area_of_handling_hit_body_entered(body):
	if(body.has_method("handle_hit")):
		body.handle_hit(damage)
