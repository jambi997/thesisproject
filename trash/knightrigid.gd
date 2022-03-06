extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"




export (int) var speed = 300

var start_health = 100
var health = start_health
var alive = true
var energyst= 30
var energy = energyst
var y = false
var velocity = Vector2()
export (int) var damage = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed('attack')and energy > 0:
		$AnimationPlayer.play("attack")
		y = true
	else:
		y = false
		#$Timer
	if Input.is_action_pressed('down'):
		velocity.y += 100
	if Input.is_action_pressed('up'):
		velocity.y -= 100
	if Input.is_action_pressed('right'):
		velocity.x += 100
	if Input.is_action_pressed('left'):
		velocity.x -= 100
	velocity = velocity.normalized() * speed


	if velocity.length() != 0 and y == false :
		$AnimationPlayer.play("run")
	if velocity.length() == 0 and y == false :
		$AnimationPlayer.play("idle")
	
func draggink(amount):
	pass
	
	
func staminaaa(amount):
	energy -= amount
	emit_signal("energy_changed",(energy * 30/ energyst))
	energy * 30 / energyst
	$stamina.rect_size.x = 30 * energy / energyst
	
func take_damage(amount):
	#$HealthBar.show()
	health -= amount
	#emit_signal("health_changed", (health * 30 / start_health))
	health * 30 / start_health
	$Bar.rect_size.x = 30 * health / start_health
	if health <= 0:
		alive = false
		get_tree().change_scene("res://menu.tscn")
		#queue_free()
		#$Camera2D.current = false
		#$Canvaslayer.visible = true
	
	
func _physics_process(delta):
	get_input()
	velocity = add_force(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_hitbox_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage) # Replace with function body.


func _on_Timer_timeout():
	y = false



func _on_Timer2_timeout():
	if y == true :
		energy -= 3
		$stamina.rect_size.x = 30 * energy / energyst
		
	elif y== false and energy < 30:
		energy += 7
		$stamina.rect_size.x = 30 * energy / energyst

	if energy > 30:
		energy = 30
		$stamina.rect_size.x = 30 * energy / energyst
