extends Node2D
func _ready() -> void:
	pass # Replace with function body.


func _on_Area2D_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		body.die()
		return
	body.queue_free()


func _on_Area2D2_body_entered(body: Node) -> void:
	var normal = Vector2(0, 1)
	if (body.is_in_group("animals")):
		body.is_near_edge = true
		body.edge_normal = normal


func _on_Area2D2_body_exited(body: Node) -> void:
	if (body.is_in_group("animals")):
		body.is_near_edge = false


func _on_Area2D3_body_entered(body: Node) -> void:
	var normal = Vector2(1, 0)
	if (body.is_in_group("animals")):
		body.is_near_edge = true
		body.edge_normal = normal

func _on_Area2D3_body_exited(body: Node) -> void:
	if (body.is_in_group("animals")):
		body.is_near_edge = false


func _on_Area2D4_body_entered(body: Node) -> void:
	var normal = Vector2(0, -1)
	if (body.is_in_group("animals")):
		body.is_near_edge = true
		body.edge_normal = normal


func _on_Area2D4_body_exited(body: Node) -> void:
	if (body.is_in_group("animals")):
		body.is_near_edge = false


func _on_Area2D5_body_entered(body: Node) -> void:
	var normal = Vector2(-1, 0)
	if (body.is_in_group("animals")):
		body.is_near_edge = true
		body.edge_normal = normal


func _on_Area2D5_body_exited(body: Node) -> void:
	if (body.is_in_group("animals")):
		body.is_near_edge = false
