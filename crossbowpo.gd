extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var damage = 30
var damage2 = 10
var stamdam = 3
var beam = 2
onready var Knight = get_parent()
var canshoot = true
var canshoot2 = true
var fball  = preload("res://projectiles/spitoflizard2.tscn")
var fball2  = preload("res://projectiles/spitoflizard3.tscn")
var parent 
# Called when the node enters the scene tree for the first time.
func _ready():
	frame = 0
	#$ColorRect.scale.x = 1
	#$ColorRect.scale.y = 1
	#pass # Replace with function body.
	parent = get_parent()

func shoot():
	canshoot= false
	var b = fball.instance()
	b.start_at($mouth.global_position, $mouth.global_rotation)
	$bullet.add_child(b)
	$shoottimer.start()
	
func shoot2():
	canshoot2= false
	var b = fball2.instance()
	b.start_at($mouth.global_position, $mouth.global_rotation)
	$bullet.add_child(b)
	$spectimer.start()
	$shoottimer.start()

func attack():
	if canshoot == true:
		shoot()
		$AnimationPlayer.play("shoot")
		canshoot = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func rangedattack():
	if canshoot2 == true:
		shoot2()
		$AnimationPlayer.play("shoot")
		canshoot2 = false


func _on_shoottimer_timeout():
	canshoot = true
	if canshoot2 == false:
		frame = 3
	if canshoot2 == true:
		frame = 0

func _on_AnimationPlayer_animation_finished(anim_name):
	#frame = 0
	pass


func _on_spectimer_timeout():
	canshoot2 = true
	frame = 0
