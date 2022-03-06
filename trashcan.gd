extends Node

	for i in range(1,2):
		#xy= xy + 1
		
		
		var enemy =ladder.instance()
		#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x = rand.randf_range(randx1, randx2)  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y = rand.randf_range(randy1, randy2)  #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
		var blocked = false
		enemy.position.y = y
		enemy.position.x = x
		add_child(enemy)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func enemy_spawner():
	var rand = RandomNumberGenerator.new()
	#var enemy =Enemy.instance()
	
	for i in range(1,3):
		#xy= xy + 1
		
		
		var enemy =Enemy.instance()
		#var room = rooms[1 + randi() % (rooms.size() - 1)]
		rand.randomize()
		var x =rand.randf_range(-2, 2)  #room.position.x  + 1 + randi() % int(room.size.x - 2)#rand.randf_range(-500, 500) #in $Rooms.get_children()
		rand.randomize()
		var y =rand.randf_range(-2, 2)  #room.position.y + 1 + randi() % int(room.size.y - 2) #rand.randf_range(-500, 500) #in $Rooms.get_children()
		var blocked = false
		enemy.position.y = y
		enemy.position.x = x
		add_child(enemy)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func rotate(deg):
	turntimer.start()
	while deg > mesh.rotation_degrees and torf == true:
		mesh.rotation_degrees += 1
		torf = false
	while deg < mesh.rotation_degrees and torf == true:
		mesh.rotation_degrees -= 1
		torf = false
	if deg == mesh.rotation_degrees:
		turntimer.stop()

func _on_Turn_Timer_timeout():
	turntimer.start()
	torf = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	if player != null:
		playar =  rotation_degrees + position.x - player.position.x 
		pleyer =  rotation_degrees + position.y - player.position.y
	if playar <=0 and pleyer <=0 and player != null:
		rotation_degrees += 1
	if playar >0 and pleyer >0 and player != null:
		rotation_degrees -= 1
	if playar <0 and pleyer >0 and player != null:
		rotation_degrees += 1
	if playar >0 and pleyer <0 and player != null:
		rotation_degrees -= 1
# var a = 2
# var b = "text"
onready var nav_2d : Navigation2D = $Navigation2D
onready var line_2d : Line2D = $Line2D
onready var character : Sprite = $Character

func _unhandled_input(event: InputEvent) -> void:
	if not even is InputEventMouseButton:
		return
	if even.button_index != BUTTON_LEFT or not event.pressed:
		return





onready var nav_2d : Navigation2D = $Navigation2D
onready var line_2d : Line2D = $Line2D
onready var character : KinematicBody2D = $Character

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	var new_path : = nav_2d.get_simple_path(character.global_position, event.global_position)
	line_2d.points = new_path
	character.path = new_path







