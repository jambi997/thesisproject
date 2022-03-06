extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var damage = 10
var speed = 1200
var fball  = preload("res://projectiles/spitpoison2.tscn")
var parent
# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	parent = get_parent()
	
	
func start_at(pos ,dir):
	position = pos
	rotation = dir
	#damage = dmg

func _physics_process(delta):
	position += transform.x * speed * delta







func _on_Timer_timeout():
	var poison = fball.instance()
	#parent.add_child(poison)
	parent.call_deferred("add_child", poison)
	poison.start_at(global_position, global_rotation)
	queue_free()





func _on_spitoflizard_body_entered(body):

	if body.has_method("take_damage"):
		body.take_damage(damage) # Replace with function body.
	#speed = 0

	queue_free()
