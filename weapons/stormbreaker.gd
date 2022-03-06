extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var damage = 10
var damage2 = 10
var stamdam = 3
var beam = 2
onready var Knight = get_parent()
var canshoot = true

var parent 
# Called when the node enters the scene tree for the first time.
func _ready():

	parent = get_parent()
	

		
	
func attack():
	$AnimationPlayer.play("attack1")
	$ColorRect.grow_horizontal
	$ColorRect.rect_scale.y = beam
	
	
	
var blood  = preload("res://scenes/blood.tscn")
func blood():

	var b = blood.instance()
	b.start_at($ColorRect/mouth.global_position, $ColorRect/mouth.global_rotation)
	$blood.add_child(b)


func rangedattack():
	if canshoot == true and beam > 0 :
		$AnimationPlayer.play("attack2")
		if $ColorRect.rect_scale.y < 10000:
			$ColorRect.rect_scale.y += 130
			beam -= 0.25
			#beam -= 1
			#$ColorRect/beamhit/CollisionShape2D.disabled = false
	


func _on_Area2D_body_entered(body):
	
	if body.has_method("take_damage"):
		body.take_damage(damage) 
		if beam < 7:
			beam += 0.5
		#blood()
	#parent.add_child(poison)

		

func _on_beamhit_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage2)
		#blood()
	$ColorRect.rect_scale.y = beam
	canshoot = false
	$Timer.start()
	
	#$ColorRect/beamhit/CollisionShape2D.disabled = true
func _on_Timer_timeout():
	canshoot = true
	#beam -= 1
	$ColorRect.rect_scale.y = beam
	#beam -= 1


func _on_AnimationPlayer_animation_started(animation):
	#if animation == "attack1":
		#Knight.staminaaa(5)
	pass

func _on_AnimationPlayer_animation_finished(animation):
	if animation == "attack1":
		Knight.staminaaa(5)
	if animation == "attack2":
		$ColorRect.rect_scale.y = beam
