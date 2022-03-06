extends KinematicBody2D
#class_name Knight

# Declare member variables here. Examples:
# var a = 2
# var b = "text"




export (int) var speed = 300
var fball  = preload("res://projectiles/fireball2.tscn")
var start_health = 100
var health = start_health
var alive = true
var energyst= 30
var energy = energyst
var y = false
var velocity = Vector2()
export (int) var damage = 30
var canshoot = true
var s = false
var velq = true
var candodge = true

#var weapon2 = preload("res://weapons/stormbreaker.tscn")
var candrink = true

#var weapon
onready var weapon = null #= get_node("sword")
#weapon.visible = false
# Called when the node enters the scene tree for the first time. getnode()
func _ready():
	#addweapon()
	pass
	#$hppot.rotation = false
	#pass # Replace with function body.
	#addweapon()
#func add_scent():
#	var scent      = scent_scene.instance()
#	scent.player   = player
#	scent.position = player.position
#	Game.level.effects.add_child(scent)
#	scent_trail.push_front(scent)

func addweapon(weapons):
	#weapon = weapons
	if weapon != null:
		weapon.visible = false
	match weapons:
		1:
			weapon = get_node("stormbreaker")
		2:
			weapon = get_node("sword")
			
	weapon.visible = true




func get_input():
	look_at(get_global_mouse_position())
	#addweapon()
	velocity = Vector2()
	if Input.is_action_pressed('attack')and energy > 3:
		#weapon
		#$sword/AnimationPlayer.play("attack")
		if weapon.has_method("attack"):
			weapon.attack()
			#y = true
		#$AnimationPlayer.play("attack")
		#y = true

		#$Timer
	if Input.is_action_pressed('attack2')and energy > 3:
		#if canshoot == true:
		#	shoot()
		#$AnimationPlayer.play("attack")
		#s = true
		if weapon.has_method("rangedattack"):
			weapon.rangedattack()
			#y = true
		#energy -= 29
		#$stamina.rect_size.x = 30 * energy / energyst
	else:
		s = false

	if Input.is_action_pressed('dodge')and energy > 9:
		if candodge == true:
			dodge()
			#energy -= 10
			$stamina.rect_size.x = 30 * energy / energyst
			candodge = false
			y = true
		#speed = 1000
		#$dodgetimer.start()
		#velq = false
			s = true
	else:
		s = false
		
	if Input.is_action_pressed('down') and velq == true:
		velocity.y += 100
	if Input.is_action_pressed('up') and velq == true:
		velocity.y -= 100
	if Input.is_action_pressed('right') and velq == true:
		velocity.x += 100
	if Input.is_action_pressed('left') and velq == true:
		velocity.x -= 100
	velocity = velocity.normalized() * speed
	if Input.is_action_just_pressed('ffive'):
		get_tree().change_scene("res://maps/world.tscn")
	if Input.is_action_just_pressed("drink"):
		heal()
	
	if velocity.length() != 0 and y == false :
		$AnimationPlayer.play("run")
	if velocity.length() == 0 and y == false :
		$AnimationPlayer.play("idle")
	

	
func heal():
	if candrink == true:
		if health < 100:
			take_damage(-50)
			candrink = false
		$hppot.frame = 0
		$hppot/hpottimer.start()
		if health > 100:
			health = 100
			take_damage(0)
	
func shoot():
	canshoot= false
	var b = fball.instance()
	b.start_at($mouth.global_position, $mouth.global_rotation)
	$bullet.add_child(b)
	$shoottimer.start()
	
func dodge():
	speed = 1000
	$dodgetimer.start()
	$candodgetimer.start()
	$AnimationPlayer.play("dodge")
	#if velocity.length() != 0 :
		#s = false
	candodge = false
	$stamtimer.start()
	
func staminaaa(amount):
	energy -= amount
	#emit_signal("energy_changed",(energy * 30/ energyst))
	energy * 30 / energyst
	$stamina.rect_size.x = 30 * energy / energyst
	y = true
	$stamtimer.start()
	
var blood  = preload("res://scenes/blood.tscn")
func blood():

	var bblood = blood.instance()
	bblood.start_at(position, rotation)
	get_parent().call_deferred("add_child", bblood)
	
	
func take_damage(amount):
	#$HealthBar.show()
	health -= amount
	blood()
	#emit_signal("health_changed", (health * 30 / start_health))
	health * 30 / start_health
	$Bar.rect_size.x = 30 * health / start_health
	y = true
	$AnimationPlayer.play("hurt")
	$Timer3.start()
	if health <= 0:
		alive = false
		get_tree().change_scene("res://menu.tscn")
		#queue_free()
		#$Camera2D.current = false
		#$Canvaslayer.visible = true
	
	
func _physics_process(delta):
	get_input()
	#addweapon()
	velocity = move_and_slide(velocity)
	#$hppot.rotation_degrees = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Timer_timeout():
	y = false



func _on_Timer2_timeout():
	if y == true :
		energy -= 0
		$stamina.rect_size.x = 30 * energy / energyst
		
	if s == true :
		energy -= 20
		$stamina.rect_size.x = 30 * energy / energyst
		
	elif y== false and s == false and energy < 30:
		energy += 10
		$stamina.rect_size.x = 30 * energy / energyst

	if energy > 30:
		energy = 30
		$stamina.rect_size.x = 30 * energy / energyst


func _on_shoottimer_timeout():
	canshoot = true


func _on_dodgetimer_timeout():
	speed = 300
	velq = true


func _on_candodgetimer_timeout():
	candodge = true


func _on_stamtimer_timeout():
	y = false


func _on_Area2D_body_entered(body):
	#queue_free()
	#health -= 1000
	pass





func _on_AnimationPlayer_animation_finished(animation):
	#if animation == "dodge":
		#staminaaa(10)
	pass
	#pass # Replace with function body.


func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "dodge":
		staminaaa(10)


func _on_hpottimer_timeout():
	$hppot.frame = 1
	candrink = true


func _on_hitbox_area_shape_entered(area_id, area, area_shape, self_shape):
	pass # Replace with function body.
	
	
	
	









