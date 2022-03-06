extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fball  = preload("res://projectiles/batsplit.tscn")
enum states {CHASE , ATTACK , CHILL , DEATH, SHOOT, SLASH}
var state
var velocity = Vector2.ZERO
var run_speed = 200
var chillspeed = 70
var rush_speed = 700
var start_health = 5
var health = start_health
var alive = true
export (int) var damage = 5
export (int) var taildamage = 40
var player = null
var y = false
var parent
export (float) var rotation_speed = 2
var rotation_dir = 0
var canshoot = true
var zed
# Called when the node enters the scene tree for the first time.
func _ready():
	state = states.CHILL
	#pass # Replace with function body.

func shoot():
	canshoot= false
	var b = fball.instance()
	b.start_at($mouth.global_position, $mouth.global_rotation)
	$bullet.add_child(b)
	$shoottimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	choose_action()
	#$shoottimer.start()

	zed = delta
	if velocity.length() != 0 and y == false :
		$AnimationPlayer.play("run")
	if velocity.length() == 0 and y == false and state != states.SHOOT:
		$AnimationPlayer.play("chill")
	velocity = move_and_slide(velocity)
	#rotation += rotation_dir 
	rotation += rotation_dir * rotation_speed * delta

	var target= player


func start_at(pos ):
	position = pos
	#rotation = dir

var bloods  = preload("res://scenes/blood.tscn")
func blood():

	var b = bloods.instance()
	b.start_at(position, rotation)
	get_parent().call_deferred("add_child", b)

func choose_action():
	velocity = Vector2.ZERO
	var target
	match state:
		states.CHASE:
			target= player
			#rotation = lerp_angle(rotation ,target.position.angle_to_point(position) , rotation_speed * zed  )
			look_at(player.position)
			#lerp_angle()
			velocity = Vector2(run_speed,0).rotated((rotation)) #(target.position - position).normalized() * run_speed

						


		states.CHILL:
			velocity = Vector2(chillspeed,0).rotated((rotation))
			rotation -= 0.01
		states.SHOOT:
			#TweenNode.interpolate_property(self, "transform/rot")
			target = player
			rotation = lerp_angle(rotation ,target.position.angle_to_point(position) , rotation_speed * zed )
			#look_at(player.position)
			#$AnimationPlayer.play("attack")
			if canshoot == true:
				shoot()


func take_damage(amount):
	#$HealthBar.show()
	health -= amount
	blood()
	$chaserange/CollisionShape2D.scale.x = 2.5
	$chaserange/CollisionShape2D.scale.y = 2.5
	#emit_signal("health_changed", (health * 100 / start_health))
	health * 100 / start_health
	#$Bar.rect_size.x = 64 * health / start_health
	#$AnimationPlayer.play("hurt")
	if health <= 0:
		alive = false
		queue_free()







func _on_Area2D_body_entered(body):
	player = body
	state = states.SHOOT


func _on_Area2D_body_exited(body):
	player = body
	state = states.CHASE


func _on_shoottimer_timeout():
	canshoot = true


func _on_suicidezone_body_entered(body):
	queue_free()


func _on_chaserange_body_entered(body):
	player = body
	state = states.CHASE
	$chaserange/CollisionShape2D.scale.x = 2.5
	$chaserange/CollisionShape2D.scale.y = 2.5




func _on_chaserange_body_exited(body):
	player = null
	state = states.CHILL


func _on_Navigation2D_draw():
	pass # Replace with function body.
