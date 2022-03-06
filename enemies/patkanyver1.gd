extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum states {CHASE , ATTACK , CHILL }
var state
var velocity = Vector2.ZERO
var run_speed = 200
var walk_speed = 100
var start_health = 2
var health = start_health
var alive = true
export (int) var damage = 4
var player = null
var y = false
var parent
export (float) var rotation_speed = 1.5
var rotation_dir = 0
var knockback = Vector2.ZERO
var fball  = preload("res://projectiles/spitpoison.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	alive = true
	#emit_signal("health_changed", health)
	parent = get_parent()

func _physics_process(delta):
	choose_action()

	
	if velocity.length() != 0 and y == false :
		$AnimationPlayer.play("run")
	if velocity.length() == 0 and y == false :
		$AnimationPlayer.play("chill")
	velocity = move_and_slide(velocity)
	#rotation += rotation_dir * rotation_speed * delta
	if player != null : #and state != states.ATTACK :
		look_at(player.position)
	
	
var bloods  = preload("res://scenes/blood.tscn")
func blood():

	var b = bloods.instance()
	b.start_at(position, rotation)
	parent.call_deferred("add_child", b)
	
	
func start_at(pos ):
	position = pos
	#rotation = dir
	
func choose_action():
	velocity = Vector2.ZERO
	var target
	match state:
		states.CHASE:
			target= player
			velocity = (target.position - position).normalized() * run_speed
			
		states.ATTACK:
			y = true
			target = player
			$AnimationPlayer.play("attack")
		states.CHILL:
			velocity = Vector2.ZERO
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func take_damage(amount):
	#$HealthBar.show()
	health -= amount
	blood()
	#emit_signal("health_changed", (health * 100 / start_health))
	#health * 100 / start_health
	#$Bar.rect_size.x = 64 * health / start_health
	if health <= 0:
		alive = false
		queue_free()
		var poison = fball.instance()
		parent.call_deferred("add_child", poison)
		poison.start_at(global_position, global_rotation)
		

func _on_senserange_body_entered(body):
	state = states.CHASE
	player = body

func _on_senserange_body_exited(body):
	player = null
	state =  states.CHILL


func _on_attackrange_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)


func _on_attacksenserange_body_entered(body):
	state = states.ATTACK


func _on_attacksenserange_body_exited(body):
	#if player == body:
	state = states.CHASE
	#else:
	#	state= states.CHILL

func _on_Timer_timeout():
	y = false





func _on_suicidezone_body_entered(body):
	queue_free()


func _on_hurtbox_area_entered(area):
	#knockback = Vector2.RIGHT * 400
	pass

func _on_hurtbox_body_entered(body):
	#knockback = Vector2.RIGHT * 100
	pass
