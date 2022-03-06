extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var damage = 3
var speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_at(pos ,dir):
	position = pos
	rotation = dir
	#damage = dmg

func _physics_process(delta):
	position += transform.x * speed * delta





	#queue_free()


func _on_Timer_timeout():
	queue_free()





func _on_spitpoison_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
