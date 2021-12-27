extends Node2D

var rabbits = 3
var wolves = 10
var deers = 4

var rabbitArray : Array
var wolfArray : Array
var deerArray : Array

func _ready():
	while rabbits > 0:
		rabbits *= 10
		var rng  = RandomNumberGenerator.new()
		rng.randomize()
		var spawnPoint = Vector2(rng.randi_range(-600, 600), rng.randi_range(-600, 600))
		while rabbits*10 > 0:
			randomize()
			var rabbit = preload("res://Animals/Rabbit/Rabbit.tscn").instance()
			var magicNumber1 = randf()
			var magicNumber2 = randf()
			rabbit.global_position = Vector2(spawnPoint.x + 400*magicNumber1, spawnPoint.y + 400*magicNumber2)
			rabbitArray.append(rabbit) 
			add_child(rabbit)
			rabbits -= 1
	while wolves > 0:
		var rng  = RandomNumberGenerator.new()
		rng.randomize()
		var spawnPoint = Vector2(rng.randi_range(-600, 600), rng.randi_range(-600, 600))
		while wolves > 0:
			randomize()
			var magicNumber1 = randf()
			var magicNumber2 = randf()
			var wolf = preload("res://Animals/Wolf/Wolf.tscn").instance()
			wolf.global_position = Vector2(spawnPoint.x + 500*magicNumber1, spawnPoint.y + 500*magicNumber2)
			wolfArray.append(wolf) 
			add_child(wolf)
			wolves -= 1
	while deers > 0:
		var rng  = RandomNumberGenerator.new()
		rng.randomize()
		var spawnPoint = Vector2(rng.randi_range(-600, 600), rng.randi_range(-600, 600))
		var deersAmount = rng.randi_range(2, 6)
		while deersAmount > 0:
			randomize()
			var deer = preload("res://Animals/Deer/Deer.tscn").instance()
			var magicNumber1 = randf()
			var magicNumber2 = randf()
			deer.global_position = Vector2(spawnPoint.x + 200*magicNumber1, spawnPoint.y + 200*magicNumber2)
			deerArray.append(deer) 
			add_child(deer)
			deersAmount -= 1
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
