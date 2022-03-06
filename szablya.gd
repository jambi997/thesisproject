extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var damage = 13
var wavedamage = 40
var stamdam = 3
var beam = 2
onready var Knight = get_parent()
var canshoot = true
var parent 
var attack = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	frame = 1

func attack():
	#if swordstate == 1:
	if attack == 2:
		$AnimationPlayer.play("attack1")
		if canshoot == false:
			frame = 0

func rangedattack():
	if canshoot == true  :
		$AnimationPlayer.play("attack2")
		canshoot = false
		$Timer.start()
		attack= 1


func _on_Timer_timeout():
	canshoot = true
	frame = 1

func _on_sword_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		

func _on_wavehead_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(wavedamage)


func _on_wavebody_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack1":
		Knight.staminaaa(5)
	if anim_name == "attack2":
		canshoot = false
		attack = 2
		#$Timer.start()


func _on_Timer2_timeout():
	if frame == 1:
		frame = 2
	elif frame == 2:
		frame = 1
