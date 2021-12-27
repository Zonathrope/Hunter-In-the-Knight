extends KinematicBody2D

const MAX_HP = 5
var hp = 5

enum {
  IDLE,
  WANDER,
}

var velocity = Vector2.ZERO
var location = Vector2.ZERO
var acceleration = Vector2.ZERO
var state = IDLE

const MAX_SPEED = 2000

var circle_distance = 40
var circle_radius = 20
var wanderAngle = 20
var angle_change = 10

func _physics_process(delta):
	match state:
		IDLE:
			if $Timer.is_stopped():
				state = WANDER
				$Timer.start()
				$Timer.wait_time = 2
			velocity *= 0
		WANDER:
			wander(delta)
			if $Timer.is_stopped():
				state = IDLE
				$Timer.start()
				$Timer.wait_time = 1
				
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
  
func setAngle(vector, value):
	var length = vector.length();
	vector.x = cos(value) * length;
	vector.y = sin(value) * length;
	return vector

func die():
	queue_free()
	
func handle_hit(taken_damage: int) -> void:
	hp -= taken_damage
	print(taken_damage)
	print(hp)
	if hp <= 0:
		queue_free()
	
