extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var xy
const Enemy = preload("res://patkany.tscn")
const turtle = preload("res://turtle.tscn")
const ladder = preload("res://ladder.tscn")
const knight = preload("res://knight.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = RandomNumberGenerator.new()

	$TileMap.generate()
	enemy_spawner()
	playerspawner()
			#break
	
	
	
	#$TileMap.generate()
	
func playerspawner():
	var rand = RandomNumberGenerator.new()
	for i in range(1,2):
		#xy= xy + 1
		
		
		var enemy =knight.instance()
		#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x = rand.randf_range(0, $TileMap.map_w * 32)  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y = rand.randf_range(0, $TileMap.map_h * 32)  #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
		var blocked = false
		enemy.position.y = y
		enemy.position.x = x
		#if $TileMap.get_cell(x, y) == $TileMap.Tiles.GROUND:
		add_child(enemy)
	
	
func playerspawner2():
	#var tiles = $Tilemap.get_used_cells_by_id(my_id)
	#or tile in tiles:
		#if rand.randf_range(1, 5) < 2: # This is randomly selecting tile to spawn enemy with 40% of chance
	# Code to spawn enemy
		#	add_child(knight.instance())
	pass
	
	
func enemy_spawner():
	var rand = RandomNumberGenerator.new()
	#var enemy =Enemy.instance()
	var sex = rand.randf_range(0, 10)
	
	for i in range(1,2):
		#xy= xy + 1
		
		
		var enemy =ladder.instance()
		#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x = rand.randf_range(0, $TileMap.map_w * 32)  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y = rand.randf_range(0, $TileMap.map_h * 32)   #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
		var blocked = false
		enemy.position.y = y
		enemy.position.x = x
		add_child(enemy)

	
	
	for i in range(1,50):
		#xy= xy + 1
		
		
		var enemy =Enemy.instance()
		#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x = rand.randf_range(0, $TileMap.map_w * 32)  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y = rand.randf_range(0, $TileMap.map_h * 32)   #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
		#var blocked = false
		enemy.position.y = y
		enemy.position.x = x
		#if $TileMap.get_cell(x, y) == $TileMap.Tiles.GROUND:
		add_child(enemy)


	for i in range(1,2):
		#xy= xy + 1
		
		
		var enemy =turtle.instance()
		#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x = rand.randf_range(0, $TileMap.map_w * 32)  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y = rand.randf_range(0, $TileMap.map_h * 32)    #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
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
