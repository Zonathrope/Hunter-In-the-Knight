extends KinematicBody2D

export(PackedScene) var BULLET_SCENE
export(PackedScene) var PLAYER_SCENE

const MAX_HP = 5
var hp = 5

var player = null
var move = Vector2.ZERO

var speed = 1

func _physics_process(delta):
	move = Vector2.ZERO
	
	if player != null:
		move = position.direction_to(player.position) * speed
	else:
		move = Vector2.ZERO
	move = move.normalized()
	
	move = move_and_collide(move)

func _on_Area2D_body_entered(body):
	if body != self:
		if body == get_node("../Player"):
			player = body


func _on_Area2D_body_exited(body):
	if body == get_node("../Player"):
		player = null

func fire():
	var bullet = BULLET_SCENE.instance()
	bullet.position = get_global_position()
	bullet.player = player
	get_parent().add_child(bullet)
	$Timer.set_wait_time(1)
	

func _on_Timer_timeout():
	if player != null:
		fire()
		
		
func handle_hit(taken_damage: int) -> void:
	hp -= taken_damage
	print(taken_damage)
	print(hp)
	if hp <= 0:
		queue_free()
