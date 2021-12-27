extends KinematicBody2D

const MAX_HP = 5
var hp = 5

var location = Vector2.ZERO
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

const MAX_SPEED = 200000
const MAX_ACCELERATION = 100

func _physics_process(delta):
	seek(get_global_mouse_position(), delta)
	velocity += acceleration
	velocity = velocity.clamped(MAX_SPEED)
	location += velocity 
	location = move_and_slide(location * delta)
	acceleration *= 0 
	
func wander(delta):
	var circleCenter = Vector2()
	circleCenter = Vector2(velocity.x, velocity.y)
	circleCenter = circleCenter.normalized()
	circleCenter *= circle_distance
	var displacement = Vector2(0, -1)
	displacement *= circle_radius
	displacement = setAngle(displacement, wanderAngle)
	wanderAngle += randi() * angle_change - angle_change * 0.5;
	acceleration = (circleCenter + displacement) * MAX_SPEED * delta
	
func seek(target, delta):
	var desired = target - global_position
	desired = desired.normalized()
	desired *= (MAX_SPEED * delta)
	var steer = desired - velocity
	steer = steer.clamped(MAX_ACCELERATION)
	acceleration += steer 
		
func handle_hit(taken_damage: int) -> void:
	hp -= taken_damage
	print(taken_damage)
	print(hp)
	if hp <= 0:
		queue_free()
	
