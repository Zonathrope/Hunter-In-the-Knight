extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Area2D_body_exited(body: Node) -> void:
	body.queue_free()


func _on_Area2D2_body_entered(body: Node) -> void:
	var normal = Vector2(-10, 0)
	if (body.is_in_group("animals")):
		body.velocity = body.velocity.reflect(normal)
	pass # Replace with function body.
