extends Area2D



onready var weapons = 3#get_node("stormbreaker")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_wpbuystormi_body_entered(body):

		if body.has_method("addweapon"):
			body.addweapon(weapons)
