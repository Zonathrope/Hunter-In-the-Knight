extends CanvasLayer

onready var player = $"../Player/Player_stats"
onready var playerCurrent = $"../Player"

onready var ammoLabel = $UI/Ammo

var png_x = 16

func _process(delta):
	ammoLabel.text = "Ammo:" + str(playerCurrent.ammo)

func _ready():
	ammoLabel.text = "Ammo:" + str(playerCurrent.ammo)

