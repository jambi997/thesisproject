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
var wid = Itemization.wid
#var weapon2 = preload("res://weapons/stormbreaker.tscn")
var candrink = true
var knockback = Vector2.ZERO
#var weapon
onready var weapon = null #= get_node("sword")

func _ready():
	addweapon(wid)
	Itemization.canheal = 0
	#$Bar.rotating = false

func addweapon(weapons):
	#weapon = weapons
	if weapon != null:
		weapon.visible = false
	match weapons:
		1:
			weapon = get_node("stormbreaker")
		2:
			weapon = get_node("sword")
		3:
			weapon = get_node("crossbowpo")
		4:
			weapon = get_node("szablya")
		5:
			weapon = get_node("ladzsavill")
			
	weapon.visible = true
	Itemization.wid = weapons



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
			take_damage(-99)
			candrink = false
			Itemization.canheal = 1
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
	if amount > 0:
		blood()
	#emit_signal("health_changed", (health * 30 / start_health))
	health * 30 / start_health
	$Bar.rect_size.x = 30 * health / start_health
	y = true
	$AnimationPlayer.play("hurt")
	$Timer3.start()
	if health <= 0:
		Itemization.spawncount = 1
		Itemization.wwcount = 1
		Itemization.bosshp = 500
		Itemization.canheal = 0
		alive = false
		get_tree().change_scene("res://menu.tscn")
		#queue_free()
		#$Camera2D.current = false
		#$Canvaslayer.visible = true
func knockback(knockili):
	knockback = Vector2(-knockili, 0).rotated(rotation)

	
func _process(delta):
	Itemization.kpozx = position.x
	Itemization.kpozy = position.y

	
	
func _physics_process(delta):
	Itemization.kpoz = position
	get_input()
	#Itemization.kpoz = position
	#addweapon()
	velocity = move_and_slide(velocity)
	#$hppot.rotation_degrees = 0
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	
	Itemization.chp = health
	Itemization.cstam = energy
	
	
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
	Itemization.canheal = 0

func _on_hitbox_area_shape_entered(area_id, area, area_shape, self_shape):
	pass # Replace with function body.
	
	
	
	









