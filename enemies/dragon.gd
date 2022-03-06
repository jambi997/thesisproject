extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const ladder = preload("res://ladders/ladder.tscn")
var fball  = preload("res://projectiles/fireball.tscn")
enum states {CHASE , ATTACK , CHILL , DEATH, SHOOT, SLASH}
var state
var velocity = Vector2.ZERO
var run_speed = 120
var rush_speed = 700
var start_health = Itemization.bosshp 
var health = start_health
var alive = true
export (int) var damage = 3
export (int) var taildamage = 20
var player = null
var y = false
var parent
export (float) var rotation_speed = 2
var rotation_dir = 0
var canshoot = true
var playar = null
var pleyer = null
var xar = null
onready var TweenNode = get_node("Tween")
#var player_position = null
#var dir = (player_position - position).normalized
var xax = 2
var rotationg = null
var zed
# Called when the node enters the scene tree for the first time.
func _ready():
	alive = true
	#emit_signal("health_changed", health)
	parent = get_parent()
func shoot():
	canshoot= false
	var b = fball.instance()
	b.start_at($mouth.global_position, $mouth.global_rotation)
	$bullet.add_child(b)
	$shoottimer.start()
	

	
	
func _physics_process(delta):
	choose_action()
	#$shoottimer.start()
	zed = delta
	
	if velocity.length() != 0 and y == false :
		$AnimationPlayer.play("run")
	if velocity.length() == 0 and y == false and state != states.SLASH and state != states.SHOOT:
		$AnimationPlayer.play("chill")
	velocity = move_and_slide(velocity)
	#rotation += rotation_dir 
	rotation += rotation_dir * rotation_speed * delta

	var target= player





func start_at(pos ):
	position = pos
	#rotation = dir
	
func choose_action():
	velocity = Vector2.ZERO
	var target
	match state:
		states.CHASE:
			target= player
			rotation = lerp_angle(rotation ,target.position.angle_to_point(position) , rotation_speed * zed  )
			#lerp_angle()
			velocity = Vector2(run_speed,0).rotated((rotation)) #(target.position - position).normalized() * run_speed
			$Sprite.rotation_degrees = -90
						
			#angle_to_pont(Vector2 to player)
			#$Sprite.rotation_degrees = -90
			#look_at(player.position)
		states.ATTACK:
			y = true
			
			target = player
			#rotation = target.position.angle_to_point(position)
			$AnimationPlayer.play("rush")
			velocity = Vector2(rush_speed,0).rotated((rotation))  
			#$Sprite.rotate(-10)         #velocity = (target.position - position).normalized() * rush_speed
			#$timer.start()
		states.CHILL:
			velocity = Vector2.ZERO
		states.SHOOT:
			#TweenNode.interpolate_property(self, "transform/rot")
			target = player
			rotation = lerp_angle(rotation ,target.position.angle_to_point(position) , rotation_speed * zed )
			#look_at(player.position)
			$AnimationPlayer.play("attack")
			if canshoot == true:
				shoot()
		states.SLASH:
			$AnimationPlayer.play("slash")
			rotate(-0.25)   
			#if canshoot == true:
			#	shoot()
			
			
			
		
		
		
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
	if amount > 3:
		health -= amount
		#emit_signal("health_changed", (health * 100 / start_health))
		health * 100 / start_health
		$Bar.rect_size.x = 64 * health / start_health
		blood()
		
		if health <= 0:
			Itemization.wwcount += 1
			Itemization.bosshp += 50
			alive = false
			queue_free()
			get_tree().change_scene("res://maps/shop.tscn")



func _on_sense_body_entered(body):
	player = body
	if xax == 2 :
		state = states.ATTACK
	if xax == 1 :
		state = states.CHASE


func _on_sense_body_exited(body):
	player = null
	state = states.CHILL


func _on_Area2D2_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	if body.has_method("knockback"):
		body.knockback(800)


func _on_Timer_timeout():
	y = false
	if player != null and state != states.SHOOT :
		state = states.CHASE



func _on_Timer2_timeout():
	#state= states.ATTACK
	if xax == 1:
		xax= 2
	elif xax == 2:
		xax = 1

func _on_damage_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	if body.has_method("knockback"):
		body.knockback(500)



func _on_shootsense_body_entered(body):
	player = body
	if state != states.ATTACK and state != states.SLASH:
		state = states.SHOOT


func _on_shootsense_body_exited(body):
	player = body
	if xax == 2 :
		state = states.ATTACK
	if xax == 1 :
		state = states.CHASE

func _on_shoottimer_timeout():
	canshoot = true


func _on_slashzone_body_entered(body):
	player = body
	#if state != states.ATTACK:
	#if xax == 1 :
	state = states.SLASH
	$slashtimer.start()
	#if xax == 1 :
	#	state = states.SHOOT
	#	$slashtimer.start()
func _on_slashzone_body_exited(body):
	#state = states.ATTACK
	pass

func _on_slashtimer_timeout():
	if player != null:
		if xax == 2 :
			state = states.ATTACK
		if xax == 1 :
			state = states.CHASE


func _on_Area2D_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(taildamage)
	if body.has_method("knockback"):
		body.knockback(800)


func _on_charget_timeout():
	#rotation += 180
	pass # Replace with function body.
