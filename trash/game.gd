extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var xy
const Enemy = preload("res://enemies/rathole.tscn")
const turtle = preload("res://enemies/turtle.tscn")
const ladder = preload("res://ladders/ladder.tscn")
const knight = preload("res://knight.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = RandomNumberGenerator.new()
	#enemy_spawner()
	$TileMap.generate()
	for i in range(1,2):
		#xy= xy + 1
		
		
		var enemy =knight.instance()
		#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x = rand.randf_range(100, 200)  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y = rand.randf_range(300, 400)  #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
		var blocked = false
		enemy.position.y = y
		enemy.position.x = x
		add_child(enemy)
	
	#$TileMap.generate()
	

func enemy_spawner():
	var rand = RandomNumberGenerator.new()
	#var enemy =Enemy.instance()
	var sex = rand.randf_range(0, 10)
	
	for i in range(1,2):
		#xy= xy + 1
		
		
		var enemy =ladder.instance()
		#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x = rand.randf_range(-200, 200)  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y = rand.randf_range(-100, 100)  #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
		var blocked = false
		enemy.position.y = y
		enemy.position.x = x
		add_child(enemy)

	
	
	for i in range(1,3):
		#xy= xy + 1
		
		
		var enemy =Enemy.instance()
		#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x = rand.randf_range(-200, 200)  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y = rand.randf_range(-100, 100)  #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
		#var blocked = false
		enemy.position.y = y
		enemy.position.x = x
		add_child(enemy)


	for i in range(1,2):
		#xy= xy + 1
		
		
		var enemy =turtle.instance()
		#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x = rand.randf_range(-200, 200)  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y = rand.randf_range(-100, 100)  #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
		var blocked = false
		enemy.position.y = y
		enemy.position.x = x
		add_child(enemy)
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	enemy_spawner()
	#pass # Replace with function body.
