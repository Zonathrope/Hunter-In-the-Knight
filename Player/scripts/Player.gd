extends KinematicBody2D
export (PackedScene) var dash_object
export(PackedScene) var BULLET_SCENE

onready var stats = $Player_stats
onready var speed: int = stats.move_speed
onready var dash_speed: int = stats.dash_speed
onready var dash_duration : float = stats.dash_duration
onready var dash_reload_duration : float = stats.dash_reload_duration
onready var attack_damage: float = stats.attack_damage
onready var max_hearts : int = stats.max_hearts
onready var current_hearts : float = stats.current_hearts
onready var ammo : int = stats.ammo
var mouse_position


var is_dashing = false
var is_dash_avaliable = true
var is_invulnerable = false
var is_attacking = false
var state = "idle"

export var acceleretaion = 500
export var deacceleration = 300

onready var UI = $"../UI-attaching"
onready var anim = $AnimationTree
onready var player_sprite = $Sprite
onready var animation_state = anim.get("parameters/playback")


var dash_timer = Timer.new()
var dash_reaload_timer = Timer.new()
var velocity = Vector2.ZERO

func _ready():
	self.add_to_group(Groups.Players)
	anim.active = true
	dash_timer.one_shot = true
	dash_reaload_timer.one_shot = true
	dash_timer.connect("timeout", self, "_on_dash_timer_timeout")
	dash_reaload_timer.connect("timeout", self, "_on_dash_reaload_timer_timeout")
	add_child(dash_timer)
	add_child(dash_reaload_timer)

func _physics_process(delta: float):
	var movement_direction = get_input_direction()
	var dash_button_pressed = is_dash_button_pressed()
	var attack_button_pressed = is_attack_button_pressed()
	handle_movement(delta, movement_direction, dash_button_pressed)
	change_state(movement_direction, dash_button_pressed, attack_button_pressed)
	mouse_position = get_local_mouse_position()
	display_animation(state)
	
func get_input_direction() -> Vector2:
	var movement_direction = Vector2.ZERO
	movement_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	movement_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return movement_direction

func is_dash_button_pressed() -> bool:
	return Input.is_action_just_pressed("dash")

func is_attack_button_pressed() -> bool:
	return Input.is_action_just_pressed("attack")

func handle_movement(delta: float, move_direction: Vector2, dash_button_pressed: bool):
	if dash_button_pressed and is_dash_avaliable:
		start_dash(dash_duration)
		velocity += move_direction.normalized() * dash_speed
		return

	if is_dashing:
		move_and_slide(velocity)
		if self.get_slide_count() != 0:
			dash_timer.stop()
			end_dash()
		return

	if move_direction != Vector2.ZERO:
		velocity = velocity.move_toward(move_direction.normalized() * speed, acceleretaion * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deacceleration * delta)
	velocity = move_and_slide(velocity)

func start_dash(dash_duration: float):
	is_invulnerable = true
	is_dash_avaliable = false
	is_dashing = true
	dash_timer.start(dash_duration)
	
	

func _on_dash_timer_timeout():
	end_dash()


func end_dash():
	is_invulnerable = false
	is_dashing = false
	velocity = Vector2.ZERO
	start_dash_reload(dash_reload_duration)

func start_dash_reload(duration: float):
	is_dash_avaliable = false
	dash_reaload_timer.start(duration)
	
func _on_dash_reaload_timer_timeout():
	is_dash_avaliable = true
	
func change_state(move_direction: Vector2, is_dashing: bool, attack_animation):
	if move_direction.length() == 0 && is_attacking == false:
		state = "idle"
	if (move_direction != Vector2.ZERO && is_attacking == false):
		anim.set("parameters/Idle/blend_position", move_direction)
		anim.set("parameters/Run/blend_position", move_direction)
		state = "run"
	if attack_animation:
		state = "attack"
	if is_dashing:
		state = "dash"


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

func _on_SwordHit_area_entered(area):
	if area.has_method("handle_hit"):
		area.handle_hit(attack_damage)

func _on_timer_ghost_timeout():
	if(is_dashing):
		var dash_sprite = preload("res://Player/scenes/dash_sprite.tscn").instance();
		get_parent().add_child(dash_sprite)
		dash_sprite.frame = player_sprite.frame
		dash_sprite.position = position

func isDead():
	if(current_hearts <= 0):
		UI.vanish()
		queue_free()

func fire():
	if ammo > 0:
		var bullet = BULLET_SCENE.instance()
		bullet.position = get_global_position()
		print(mouse_position)
		bullet.player = mouse_position
		get_parent().add_child(bullet)
		is_attacking = false
		ammo = ammo - 1


#handling damage
func take_damage(damage: float):
	current_hearts = current_hearts - damage
	UI.update_health_info(max_hearts, current_hearts)
	isDead()
