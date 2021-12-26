extends CanvasLayer


onready var label = $fps

func _process(delta):
	label.text = str(Engine.get_frames_per_second()).pad_decimals(2)
