extends Node2D

var rabbits = 3
var wolves = 3
var deers = 9

var rabbitArray : Array
var wolfArray : Array
var deerArray : Array

func _ready():
	while rabbits > 0:
		var rabbit = preload("res://Animals/Rabbit/Rabbit.tscn").instance()
		rabbit.startX = 200
		rabbit.startY = 200
		rabbitArray.append(rabbit) 
		add_child(rabbit)
		rabbits -= 1
	while wolves > 0:
		var wolf = preload("res://Animals/Wolf/Wolf.tscn").instance()
		wolf.startX = -200
		wolf.startY = 200
		wolfArray.append(wolf) 
		add_child(wolf)
		wolves -= 1
	while deers > 0:
		var deer = preload("res://Animals/Deer/Deer.tscn").instance()
		deer.startX = -200
		deer.startY = -200
		deerArray.append(deer) 
		add_child(deer)
		deers -= 1

func getRabbitsArray():
	return rabbitArray
	
func getWolvesArray():
	return wolfArray
	
func getDeersArray():
	return deerArray
	
func getPlayer():
	if get_node("YSort/Player") != null:
		return get_node("YSort/Player")
	
func getAllArray():
	var allArray : Array
	if	rabbitArray.size() > 0:
		allArray.append_array(rabbitArray)
	if	wolfArray.size() > 0:
		allArray.append_array(wolfArray)
	if	deerArray.size() > 0:
		allArray.append_array(deerArray)
	allArray.append(get_node("YSort/Player"))
	return allArray
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
