extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fball  = preload("res://projectiles/fireball2.tscn")
var damage = 10
var stamdam = 3
var heat = 0
var swordstate = 1
var canshoot = true
onready var Knight = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shoot():
	canshoot= false
	var b = fball.instance()
	b.start_at($mouth.global_position, $mouth.global_rotation)
	$bullet.add_child(b)
	$shoottimer.start()
	
func attack():
	if swordstate == 1:
		$AnimationPlayer.play("attack3")
		
	elif swordstate == 2 :
		$AnimationPlayer.play("attack4")
		if heat > 10:
			if scale.x == 1:
				scale.x = -1
			elif scale.x == -1 :
				scale.x = 1
	if heat > 3:
		swordstate = 2
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func rangedattack():
		#if canshoot == true:
		if swordstate == 2 and canshoot == true:
			shoot()
			heat = 0
			swordstate = 1
			$AnimationPlayer.play("attack")

func _on_sword_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage) # Replace with function body.
		heat += 1


func _on_Area2D_body_entered(body):
	if body.has_method("staminaaa"):
		body.staminaaa(stamdam)


func _on_shoottimer_timeout():
	canshoot = true


func _on_Area2D2_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage) # Replace with function body.
		heat += 1





func _on_AnimationPlayer_animation_finished(anim_name):
	Knight.staminaaa(1)
