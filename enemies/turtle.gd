extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum states {CHASE , ATTACK , CHILL , DEATH}
var state
var velocity = Vector2.ZERO
var run_speed = 20
var rush_speed = 500
var start_health = 40
var health = start_health
var alive = true
export (int) var damage = 12.3
var player = null
var y = false
var parent
export (float) var rotation_speed = 1.5
var rotation_dir = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	alive = true
	#emit_signal("health_changed", health)
	parent = get_parent()

func _physics_process(delta):
	choose_action()
	
	
	if velocity.length() != 0 and y == false :
		$AnimationPlayer.play("run")
	if velocity.length() == 0 and y == false :
		$AnimationPlayer.play("chill")
	velocity = move_and_slide(velocity)
	rotation += rotation_dir * rotation_speed * delta
	if player != null and state == states.CHASE: #and state != states.ATTACK :
		look_at(player.position)
	
	
func start_at(pos ):
	position = pos
	#rotation = dir
	
func choose_action():
	velocity = Vector2.ZERO
	var target
	match state:
		states.CHASE:
			target= player
			velocity = Vector2(run_speed,0).rotated((rotation)) #(target.position - position).normalized() * run_speed
			$Sprite.rotation_degrees = 90
		states.ATTACK:
			y = true
			#target = player
			$AnimationPlayer.play("attack")
			velocity = Vector2(rush_speed,0).rotated((rotation))  
			$Sprite.rotate(-10)         #velocity = (target.position - position).normalized() * rush_speed
		states.CHILL:
			velocity = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var blood  = preload("res://scenes/blood.tscn")
func blood():

	var b = blood.instance()
	b.start_at(position, rotation)
	parent.call_deferred("add_child", b)


func take_damage(amount):
	#$HealthBar.show()
	if amount != damage:
		health -= amount
		$sense/CollisionShape2D.scale.x = 2.5
		$sense/CollisionShape2D.scale.y = 2.5
		blood()
	#state= states.ATTACK
	#emit_signal("health_changed", (health * 100 / start_health))
	#health * 100 / start_health
	#$Bar.rect_size.x = 64 * health / start_health
	if health <= 0:
		alive = false
		queue_free()


func _on_sense_body_entered(body):
	player = body
	state = states.CHASE
	$sense/CollisionShape2D.scale.x = 5
	$sense/CollisionShape2D.scale.y = 5
	$Timer.start()
	$Timer2.start()

func _on_sense_body_exited(body):
	player = null
	state = states.CHILL


func _on_Area2D2_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	if body.has_method("knockback"):
		body.knockback(500)

func _on_Timer_timeout():
	y = false
	if player != null:
		state = states.CHASE

func _on_Area2D_body_entered(body):
	#state = states.ATTACK
	pass

func _on_Area2D_body_exited(body):
	#state = states.CHASE
	pass

func _on_Timer2_timeout():
	state= states.ATTACK


func _on_suicidezone_body_entered(body):
	queue_free()
