extends Area2D

onready var enemy_hp = get_parent().hp

func handle_hit(taken_damage: int) -> void:
	enemy_hp -= taken_damage
	if enemy_hp <= 0:
		get_parent().queue_free()
