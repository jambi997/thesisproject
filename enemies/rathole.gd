extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Enemy = preload("res://enemies/patkany.tscn")
var start_health = 30
var health = start_health
var alive = true
var parent
export (int) var damage = 100
##signal health_changed
# Called when the node enters the scene tree for the first time.
func _ready():
	alive = true
	#emit_signal("health_changed", health)
	parent = get_parent()
	
func enemy_spawner():

	
	var enemy =Enemy.instance()
	
	enemy.start_at($Position2D.global_position)
	$rats.add_child(enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func take_damage(amount):
	#$HealthBar.show()
	health -= amount
	#emit_signal("health_changed", (health * 100 / start_health))
	#health * 100 / start_health
	#$Bar.rect_size.x = 64 * health / start_health
	if health <= 0:
		alive = false
		#queue_free()
		$Timer.stop()
		#$Sprite.visible = false
		#$CollisionShape2D.disabled = true
		
func dead():
	if health <= 0:
		alive = false
	if alive == false:
		$Timer.stop()

func _on_Timer_timeout():
	take_damage(10)
	#pass # Replace with function body.
	enemy_spawner()
	#queue_free()


func _on_Area2D_body_entered(body):
	if alive == true:
		$Timer.start()


func _on_Area2D2_body_entered(body):
	queue_free()
