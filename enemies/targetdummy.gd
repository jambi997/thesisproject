extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var start_health = 100
var health = start_health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func take_damage(amount):
	#$HealthBar.show()
	if amount > 0:
		health -= amount
		#blood()
		#emit_signal("health_changed", (health * 100 / start_health))
		health * 100 / start_health
		$healthbar.rect_size.x = 39 * health / start_health
		if health <= 0:
			#alive = false
			health = start_health
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
