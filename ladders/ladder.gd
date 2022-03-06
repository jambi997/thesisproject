extends Sprite

var x = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_frame(0)
	#pass # Replace with function body.

func start_at(pos ):
	position = pos
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if x == true:
		get_tree().change_scene("res://maps/world.tscn")
		#get_tree().change_scene("res://game2.tscn")
		#set_frame(1)

func _on_Timer_timeout():
	x = true
	set_frame(1)
	#pass # Replace with function body.
