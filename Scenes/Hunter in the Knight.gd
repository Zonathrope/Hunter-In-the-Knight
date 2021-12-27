extends Node2D

var rabbits = 0
var wolves = 10
var deers = 10

var rabbitArray : Array
var wolfArray : Array
var deerArray : Array

func _ready():
	while rabbits > 0:
		var rabbit = preload("res://Enemies/Rabbit/Rabbit.tscn").instance()
		rabbitArray.append(rabbit) 
		add_child(rabbit)
		rabbits -= 1

func getArray():
	return rabbitArray
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
