extends Node
class_name Walker

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borders = Rect2()
var step_history =[]
var steps_since_turn = 0
var rooms = []
var count = Itemization.wwcount
var count2 = 4 #Itemization.startwwcount
var counts = 6


func _init(starting_position, new_borders):
	assert(new_borders.has_point(starting_position))
	position = starting_position
	step_history.append(position)
	borders = new_borders
	
func walk(steps):
	create_room(position)
	for step in steps:
		if steps_since_turn >= 27: #count * count2: #if randf() <= 0.25 and
			change_direction()
			
		if step():
			step_history.append(position)
		else:
			change_direction()
	return step_history
	
func step():
	var target_position = position + direction
	if borders.has_point(target_position):
		steps_since_turn += 1
		position = target_position
		return true
	else:
		return false
			
func change_direction():
	create_room(position)
	steps_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(position + direction):
		direction = directions.pop_front()

func craete_room(position, size):
	return {position = position,size = size}

func create_room(position):
	var size = Vector2(randi() % 6 + 6, randi() % 6 + 6)
	var top_left_corner = (position - size/2).ceil()    
	rooms.append(craete_room(position,size))
	for y in size.x:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x, y)
			if borders.has_point(new_step):
				step_history.append(new_step)
				
func get_end_room():
	var end_room = rooms.pop_front()

	var starting_position = step_history.front()
	for room in rooms:
		if starting_position.distance_to(room.position) > starting_position.distance_to(end_room.position):
			end_room = room
	return end_room
	


func get_first_room():
	var first_room = rooms.pop_front()
	var starting_position = step_history.front()
	
	for room in rooms:
		if starting_position.distance_to(room.position) < starting_position.distance_to(first_room.position):
			first_room = room
	return first_room



