extends Node
class_name itemids

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var wid = 2
var startwwcount = 1
var wwcount = 1
var startbosshp = 500
var bosshp = 500
var spawncount = 1
var chp = 100
var cstam = 100
var schp = 100
var scstam = 100
var kpoz = 1
var kpozx = 1
var kpozy = 1
var levelcount = 1
var canheal = 0
#var helper = wwcount +0.49


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	
	levelcount = wwcount 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
