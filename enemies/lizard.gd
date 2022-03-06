extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fball  = preload("res://projectiles/spitoflizard.tscn")
enum states {ATTACK , SPIT , CHILL , CHILL2, SLASH , CHARGE}
var state
var velocity = Vector2.ZERO
var run_speed = 300
var rush_speed = 800
var start_health = Itemization.bosshp
var health = start_health
var alive = true
export (int) var damage = 5
export (int) var taildamage = 20
var player = null
export (float) var rotation_speed = 2
var rotation_dir = 0
var canshoot = true
var parent
var zed
var y = true

func _ready():
	alive = true
	#emit_signal("health_changed", health)
	parent = get_parent()
	#rotation = -80.1

func _physics_process(delta):
	choose_action()
	#$shoottimer.start()
	zed = delta
	
	velocity = move_and_slide(velocity)

	#rotation += rotation_dir 
	rotation += rotation_dir * rotation_speed * delta

	var target= player

func choose_action():
	velocity = Vector2.ZERO
	var target
	match state:
		states.ATTACK:
			target = player
			velocity = Vector2(run_speed,0).rotated((rotation))  
			#rotation = lerp_angle(rotation ,target.position.angle_to_point(position) -80.1 , rotation_speed * zed )
			$AnimationPlayer.play("run")
		states.SPIT:
			$shootsec.stop()
		
			target = player
			rotation = lerp_angle(rotation ,target.position.angle_to_point(position) , rotation_speed * zed )
			$AnimationPlayer.play("cirlce")
			#look_at(player.position)
			#$AnimationPlayer.play("attack")
			if canshoot == true:
				shoot()
		states.CHILL:
			look_at(player.position)
			velocity = Vector2.ZERO
			#rotation = -80.1
		states.CHILL2:
			velocity = Vector2.ZERO
		states.SLASH:
			$shootsec.start()
			rotation += 0.1
			if canshoot == true:
				shoot()
			$AnimationPlayer.play("slash")
		states.CHARGE:
			#rotation = -80.1
			target = player
			velocity = Vector2(rush_speed,0).rotated((rotation))  
			#rotation = lerp_angle(rotation ,target.position.angle_to_point(position) -80.1 , rotation_speed * zed )
			$AnimationPlayer.play("run")
				
				
# Called when the node enters the scene tree for the first time.


func shoot():
	canshoot= false
	var b = fball.instance()
	b.start_at($torzs/fej/mouth.global_position, $torzs/fej/mouth.global_rotation)
	$bullet.add_child(b)
	$shoottimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var bloods  = preload("res://scenes/blood.tscn")
func blood():

	var b = bloods.instance()
	b.start_at(position, rotation)
	parent.call_deferred("add_child", b)


func take_damage(amount):
	#$HealthBar.show()
	if amount > 3:
		health -= amount
		blood()
		#emit_signal("health_changed", (health * 100 / start_health))
		health * 100 / start_health
		$torzs/Bar.rect_size.y = 120 * health / start_health
		if health <= 0:
			Itemization.wwcount += 1
			Itemization.bosshp += 50
			alive = false
			queue_free()
			get_tree().change_scene("res://maps/shop.tscn")

func _on_sense_body_entered(body):
	player = body
	state = states.SPIT


func _on_sense_body_exited(body):
	player = body
	state = states.ATTACK
	$runtimer.start()

func _on_shoottimer_timeout():
	canshoot = true


func _on_sense2_body_entered(body):
	player = body
	state = states.CHILL


func _on_sense2_body_exited(body):
	player = null
	state = states.CHILL2


func _on_swipe_body_entered(body):
	player = body
	#if y == true:
		#state = states.SLASH
		#$swipetimer.start()

func _on_statetimer_timeout():
	y = true
	state = states.SLASH
	$swipetimer.start()
	
func _on_swipetimer_timeout():
	y = false
	state = states.CHARGE
	$runtimer.start()

func _on_shootsec_timeout():
	canshoot = true


func _on_Area2D_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(taildamage) # Replace with function body.
	if body.has_method("knockback"):
		body.knockback(1000)


func _on_runtimer_timeout():
	state = states.SPIT


func _on_pushzone_body_entered(body):
	if body.has_method("knockback"):
		body.knockback(400)
