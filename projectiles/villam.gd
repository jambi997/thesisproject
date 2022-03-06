extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var damage = 10
var speed = 1000
var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	#$AnimationPlayer.play("lighning")
	pass # Replace with function body.

func start_at(pos ,dir):
	position = pos
	rotation = dir
	#damage = dmg


func _physics_process(delta):
	position += transform.x * speed * delta




	#speed = 0
	#$robbant.start()
	#queue_free()


func _on_Timer_timeout():
	queue_free()


func _on_villam_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage) # Replace with function body.
		if target != null:
			look_at(target.position)
		$AnimationPlayer.play("lighning")

func _on_villamrange_body_entered(body):
	target = body
	if target != null:
		look_at(target.position)


func _on_Area2D_body_entered(body):
	#$villamrange/CollisionShape2D.visible = true
	if target != null:
		look_at(target.position)
		
	else:
		rotation += 180
		#queue_free()
