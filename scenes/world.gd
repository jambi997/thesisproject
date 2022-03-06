extends Node2D

const Player = preload("res://knight.tscn")
const Playercam = preload("res://Camera2D.tscn")
const ladder = preload("res://ladders/ladder2.tscn")
const Rathole = preload("res://enemies/rathole.tscn")
const Rat = preload("res://enemies/patkany.tscn")
const Turtle = preload("res://enemies/turtle.tscn")
const Turtlevar1 = preload("res://enemies/turtlevar1.tscn")
const ratvar1 = preload("res://enemies/patkanyver1.tscn")
const Bat = preload("res://enemies/Bat.tscn")
const Batvar1 = preload("res://enemies/Batvar1.tscn")
var borders = Rect2(1, 1, 300, 300)
var x = 1
onready var tileMap = $TileMap
var canspawn = true
var walkcount = (Itemization.wwcount * 100) +400
var spawncount = Itemization.spawncount #Itemization.wwcount - (Itemization.startwwcount -1)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generate_level()
	#pass # Replace with function body.

func generate_level():
	var walker = Walker.new(Vector2(30, 20), borders)
	var map = walker.walk(walkcount)
	var player = Player.instance()
	#add_child(player)
	#player.position = map.front()*32
	var wcount = 100 #walker.count * 32
	
	var exit = ladder.instance()
	add_child(exit)
	exit.position = walker.get_end_room().position*32
	#var rathole = Rathole.instance()
	#for i in range(10):
	var rand = RandomNumberGenerator.new()
	var rand2 = RandomNumberGenerator.new()
	for room in walker.rooms:
		
		rand2.randomize()
		var randomspawn = rand2.randi_range(2, 7)

		if room.position*32 != map.front()*32 and canspawn == true :
			#for i in range(1,3):
			var enemy =Rathole.instance()
				#var room = rooms[1 + randi() % (rooms.size() - 1)]
			rand.randomize()
			var x = rand.randf_range(-wcount, wcount)+ room.position.x*32  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
			rand.randomize()
			var y = rand.randf_range(-wcount, wcount)+ room.position.y*32  #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
			var blocked = false
			enemy.position.y = y
			enemy.position.x = x
			
			add_child(enemy)
		#	break 
		for i in range(spawncount):
			rand2.randomize()
			match randomspawn:
				2:
					if room.position*32 != map.front()*32 :
					#for i in range(1,3):
						var enemy =Turtle.instance()
							#var room = rooms[1 + randi() % (rooms.size() - 1)]
						rand.randomize()
						var x = rand.randf_range(-wcount, wcount)+ room.position.x*32  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
						rand.randomize()
						var y = rand.randf_range(-wcount, wcount)+ room.position.y*32 #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
						
						enemy.position.y = y
						enemy.position.x = x
						
						add_child(enemy)
				3:
					if room.position*32 != map.front()*32 :
						#for i in range(1,3):
						var enemy =Rathole.instance()
							#var room = rooms[1 + randi() % (rooms.size() - 1)]
						rand.randomize()
						var x = rand.randf_range(-wcount, wcount)+ room.position.x*32  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
						rand.randomize()
						var y = rand.randf_range(-wcount, wcount)+ room.position.y*32  #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
						
						enemy.position.y = y
						enemy.position.x = x
						
						add_child(enemy)
				4:
					if room.position*32 != map.front()*32 :
						#for i in range(1,3):
						var enemy =Bat.instance()
							#var room = rooms[1 + randi() % (rooms.size() - 1)]
						rand.randomize()
						var x = rand.randf_range(-wcount, wcount)+ room.position.x*32  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
						rand.randomize()
						var y = rand.randf_range(-wcount, wcount)+ room.position.y*32  #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
						
						enemy.position.y = y
						enemy.position.x = x
						
						add_child(enemy)
				5:
					if room.position*32 != map.front()*32 :
					#for i in range(1,3):
						var enemy =Turtlevar1.instance()
							#var room = rooms[1 + randi() % (rooms.size() - 1)]
						rand.randomize()
						var x = rand.randf_range(-wcount, wcount)+ room.position.x*32  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
						rand.randomize()
						var y = rand.randf_range(-wcount, wcount)+ room.position.y*32 #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
						
						enemy.position.y = y
						enemy.position.x = x
						
						add_child(enemy)
				6:
					if room.position*32 != map.front()*32 :
					#for i in range(1,3):
						var enemy =ratvar1.instance()
							#var room = rooms[1 + randi() % (rooms.size() - 1)]
						rand.randomize()
						var x = rand.randf_range(-wcount, wcount)+ room.position.x*32  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
						rand.randomize()
						var y = rand.randf_range(-wcount, wcount)+ room.position.y*32 #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
						
						enemy.position.y = y
						enemy.position.x = x
						
						add_child(enemy)
				7:
					if room.position*32 != map.front()*32 :
					#for i in range(1,3):
						var enemy =Batvar1.instance()
							#var room = rooms[1 + randi() % (rooms.size() - 1)]
						rand.randomize()
						var x = rand.randf_range(-wcount, wcount)+ room.position.x*32  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
						rand.randomize()
						var y = rand.randf_range(-wcount, wcount)+ room.position.y*32 #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
						
						enemy.position.y = y
						enemy.position.x = x
						
						add_child(enemy)


	#return #room#walker.room
	add_child(player)
	var pcamera = Playercam.instance()
	add_child(pcamera)
	player.position = map.front()*32 #walker.get_first_room().position*32 #map.front()*32
	#exit.connect("leaving_level", self, "reload_level")

	walker.queue_free()
	for location in map:
		tileMap.set_cellv(location, 1)
	tileMap.update_bitmask_region(borders.position, borders.end)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func reload_level():
	get_tree().reload_current_scene()
	
func leaving_level():
	pass

func enemy_spawner():
	var rand = RandomNumberGenerator.new()
	#var enemy =Enemy.instance()
	var sex = rand.randf_range(0, 10)
	
	for i in range(1,3):
		#xy= xy + 1
		
		
		var enemy =Rat.instance()
		#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x = rand.randf_range(-10, 10)  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y = rand.randf_range(-10, 10)  #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
		#var blocked = false
		enemy.position.y = y
		enemy.position.x = x
		add_child(enemy)

	
	
	
