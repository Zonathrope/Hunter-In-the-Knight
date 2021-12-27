extends CanvasLayer

onready var player = $"../Player/Player_stats"
onready var current_hp : float = player.current_hearts
onready var max_hp : int = player.max_hearts
onready var playerCurrent = $"../Player"

onready var healthFull = $UI/HealthFull
onready var healthSemi = $UI/HealthSemi
onready var healthEmpty = $UI/HealthEmpty
onready var ammoLabel = $UI/Ammo

var png_x = 16

var dead = false

func _process(delta):
	if !dead:
		update_health_info(max_hp, current_hp)
		ammoLabel.text = "Ammo:" + str(playerCurrent.ammo)

func _ready():
	update_health_info(max_hp, current_hp)
	ammoLabel.text = "Ammo:" + str(playerCurrent.ammo)
	
func update_health_info(max_hp, current_hp):
	healthEmpty.rect_size.x = png_x * max_hp
	if(int(current_hp) == int(current_hp - 0.5)):
		healthSemi.rect_size.x = png_x * (int(current_hp) + 1)
		healthFull.rect_size.x = png_x * int(current_hp)
	else:
		healthFull.rect_size.x = png_x * int(current_hp)
		healthSemi.rect_size.x = 0

func vanish():
	dead = true
	healthFull.rect_size.x = 0
	healthSemi.rect_size.x = 0
