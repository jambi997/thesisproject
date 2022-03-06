extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var xy
const Enemy = preload("res://enemies/rathole.tscn")
const turtle = preload("res://enemies/turtle.tscn")
const ladder = preload("res://ladders/ladder.tscn")
const knight = preload("res://knight.tscn")

var randx1
var randx2
var randy1
var randy2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enemy_spawner():
	var rand = RandomNumberGenerator.new()
	#var enemy =Enemy.instance()
	var sex = rand.randf_range(0, 10)
	


	
	
	for i in range(1,2):
		#xy= xy + 1
		
		
		var enemy =Enemy.instance()
		#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x = rand.randf_range(randx1, randx2)  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y = rand.randf_range(randy1, randy2) #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
		#var blocked = false
		enemy.position.y = y
		enemy.position.x = x
		add_child(enemy)


	for i in range(1,2):
		#xy= xy + 1
		
		
		var enemy =turtle.instance()
		#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x = rand.randf_range(randx1, randx2)  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y = rand.randf_range(randy1, randy2)  #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
		var blocked = false
		enemy.position.y = y
		enemy.position.x = x
		add_child(enemy)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
