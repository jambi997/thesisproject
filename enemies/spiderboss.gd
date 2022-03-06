extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum states {CHASE , ATTACK , CHILL , DEATH, SHOOT, SLASH, RUSH}
var state
var velocity = Vector2.ZERO
var run_speed = 120
var rush_speed = 700
var start_health = 800
var health = start_health
var alive = true
export (int) var damage = 5
export (int) var taildamage = 20
var player = null
var y = false
var parent
export (float) var rotation_speed = 2
var rotation_dir = 0
var canshoot = true
var state_machine
var zed

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	parent = get_parent()
	state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	choose_action()
	#$shoottimer.start()
	zed = delta
	
	velocity = move_and_slide(velocity)

	#rotation += rotation_dir 
	rotation += rotation_dir * rotation_speed * delta

	var target= player

func choose_action():
	velocity = Vector2.ZERO
	var target
	match state:
		states.ATTACK:
			state_machine.travel("attack")
		states.RUSH:
			$AnimationPlayer.play("rush")
			velocity = Vector2(rush_speed,0).rotated((rotation))  
		states.CHASE:
			target = player
			rotation = lerp_angle(rotation ,target.position.angle_to_point(position) , rotation_speed * zed )
			velocity = Vector2(run_speed,0).rotated((rotation))  
















# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_fej_area_entered(area):
	pass # Replace with function body.


func _on_sense_body_entered(body):
	pass # Replace with function body.


func _on_sense_body_exited(body):
	pass # Replace with function body.


func _on_attackrange_body_entered(body):
	pass # Replace with function body.


func _on_attackrange_body_exited(body):
	pass # Replace with function body.


func _on_damagerange_body_entered(body):
	pass # Replace with function body.
