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
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var wcount = 400
var rand2 = RandomNumberGenerator.new()
var randomspawn = rand2.randi_range(1,3 )
# Called when the node enters the scene tree for the first time.
func _ready():
	rand2.randomize()
	randomspawn = rand2.randi_range(1,3 )
	pass # Replace with function body.

func spawner():
	var rand = RandomNumberGenerator.new()
	if Itemization.wwcount > 1 and Itemization.wwcount < 3 :
					#for i in range(1,3):
		var enemy =ratvar1.instance()
							#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x = rand.randf_range(-wcount, wcount)#room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y = rand.randf_range(-wcount, wcount) #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
						
		enemy.position.y = y
		enemy.position.x = x
						
		add_child(enemy)
		
		
func bigspawner():
	var rand = RandomNumberGenerator.new()
	rand2.randomize()
	match randomspawn:
		1:
			if Itemization.wwcount > 2 :
							#for i in range(1,3):
				var enemy =ratvar1.instance()
									#var room = rooms[1 + randi() % (rooms.size() - 1)]
				rand.randomize()
				var x = rand.randf_range(-wcount, wcount)#room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
				rand.randomize()
				var y = rand.randf_range(-wcount, wcount) #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
								
				enemy.position.y = y
				enemy.position.x = x
								
				add_child(enemy)
		2:
			if Itemization.wwcount > 2 :
							#for i in range(1,3):
				var enemy =Bat.instance()
									#var room = rooms[1 + randi() % (rooms.size() - 1)]
				rand.randomize()
				var x = rand.randf_range(-wcount, wcount)#room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
				rand.randomize()
				var y = rand.randf_range(-wcount, wcount) #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
								
				enemy.position.y = y
				enemy.position.x = x
								
				add_child(enemy)
		3:
			if Itemization.wwcount > 2 :
							#for i in range(1,3):
				var enemy =Batvar1.instance()
									#var room = rooms[1 + randi() % (rooms.size() - 1)]
				rand.randomize()
				var x = rand.randf_range(-wcount, wcount)#room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
				rand.randomize()
				var y = rand.randf_range(-wcount, wcount) #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
								
				enemy.position.y = y
				enemy.position.x = x
								
				add_child(enemy)

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	spawner()
	bigspawner()
	#pass # Replace with function body.
