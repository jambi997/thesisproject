extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var level = Itemization.wwcount 

# Called when the node enters the scene tree for the first time.
func _ready():
	$Healthbar2.rect_size.x = 100 * 2
	$stambar2.rect_size.x = 30 * 5
	$pot.frame = 0
	#pass # Replace with function body.
func _process(delta): #_physics_process(delta):     #_process(delta):

	level = Itemization.wwcount #Itemization.levelcount #Itemization.wwcount -3
	$Label.set_text(str(level))
	if Itemization.canheal == 0:
		$pot.frame = 0
	elif Itemization.canheal == 1:
		$pot.frame = 1
	#$Label.text =  'level' #Itemization.wwcount #- 3
	position.x = Itemization.kpozx
	position.y = Itemization.kpozy
	if $Healthbar.rect_size.x != null:
		$Healthbar.rect_size.x = Itemization.chp * 2
	if $stambar.rect_size.x != null:
		$stambar.rect_size.x = Itemization.cstam * 5
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
