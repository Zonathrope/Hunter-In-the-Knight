extends CanvasLayer

onready var player = $"../Player/Player_stats"
onready var playerCurrent = $"../Player"

onready var ammoLabel = $UI/Ammo

var png_x = 16

var dead = false

func _process(delta):
	if !dead:
		ammoLabel.text = "Ammo:" + str(playerCurrent.ammo)

func _ready():
	ammoLabel.text = "Ammo:" + str(playerCurrent.ammo)

func vanish():
	dead = true

