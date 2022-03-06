extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var damage = 40
var speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_at(pos ,dir):
	position = pos
	rotation = dir
	#damage = dmg

func _physics_process(delta):
	position += transform.x * speed * delta




func _on_fireball_body_entered(body):
	#scale.x = 4
	#scale.y = 6
	if body.has_method("take_damage"):
		body.take_damage(damage) # Replace with function body.
	#speed = 0
	#$robbant.start()
	#queue_free()


func _on_Timer_timeout():
	queue_free()


func _on_robbant_timeout():
	#pass
	scale.x = 2
	scale.y = 4

