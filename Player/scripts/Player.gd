extends KinematicBody2D
export (PackedScene) var BULLET_SCENE

onready var stats = $Player_stats
onready var speed: int = stats.move_speed
onready var attack_damage: float = stats.attack_damage
onready var max_hearts : int = stats.max_hearts
onready var current_hearts : float = stats.current_hearts
onready var ammo : int = stats.ammo
var mouse_position

var dead = false
var is_attacking = false
var state = "idle"

export var acceleretaion = 500
export var deacceleration = 300

onready var UI = $"../UI-attaching"
onready var anim = $AnimationTree
onready var player_sprite = $Sprite
onready var animation_state = anim.get("parameters/playback")

var velocity = Vector2.ZERO

func _physics_process(delta: float):
	var movement_direction = get_input_direction()
	var attack_button_pressed = is_attack_button_pressed()
	handle_movement(delta, movement_direction)
	change_state(movement_direction, attack_button_pressed)
	mouse_position = get_local_mouse_position()
	display_animation(state)
	
func get_input_direction() -> Vector2:
	var movement_direction = Vector2.ZERO
	movement_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	movement_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return movement_direction

func is_attack_button_pressed() -> bool:
	return Input.is_action_just_pressed("attack")

func handle_movement(delta: float, move_direction: Vector2):
	if move_direction != Vector2.ZERO:
		velocity = velocity.move_toward(move_direction.normalized() * speed, acceleretaion * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deacceleration * delta)
	velocity = move_and_slide(velocity)

func change_state(move_direction: Vector2, attack_animation):
	if move_direction.length() == 0 && is_attacking == false:
		state = "idle"
	if (move_direction != Vector2.ZERO && is_attacking == false):
		anim.set("parameters/Idle/blend_position", move_direction)
		anim.set("parameters/Run/blend_position", move_direction)
		state = "run"
	if attack_animation:
		state = "attack"

func display_animation(state):
	if state == "idle":
		animation_state.travel("Idle")
	if state == "attack":
		is_attacking = true
		fire()
		animation_state.travel("Attack")
	if state == "run":
		animation_state.travel("Run")

func is_attack_ended():
	is_attacking = false
	state = "idle"

func die():
	UI.vanish()
	dead = true
	queue_free()
	get_tree().quit()

func fire():
	if ammo > 0:
		var bullet = BULLET_SCENE.instance()
		bullet.position = get_global_position()
		bullet.player = mouse_position
		get_parent().add_child(bullet)
		is_attacking = false
		ammo = ammo - 1
