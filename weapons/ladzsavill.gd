extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fball  = preload("res://projectiles/villam.tscn")
var damage = 15
var stamdam = 3
var heat = 0
var swordstate = 1
var canshoot = true
onready var Knight = get_parent()
var parent
var toltes = 11
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()

func shoot():
	canshoot= false
	var b = fball.instance()
	b.start_at($mouth.global_position, $mouth.global_rotation)
	$bullet.add_child(b)
	$shoottimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func attack():
	$AnimationPlayer.play("attack")
	if toltes >10:
		frame = 1

func rangedattack():
	if canshoot == true and toltes > 10:
		shoot()
		$AnimationPlayer.play("attack2")
		canshoot = false
		toltes = 0
		#r.start()
		


func _on_Area2D_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage) # Replace with function body.
		toltes += 1


func _on_Timer_timeout():
	canshoot = true
	if toltes >10:
		frame = 1
	else :
		frame = 0
	toltes += 1

func _on_AnimationPlayer_animation_finished(anim_name):
	#if anim_name == "attack1":
	Knight.staminaaa(3)
