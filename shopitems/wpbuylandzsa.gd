extends Area2D



onready var weapons = 5   #get_node("stormbreaker")



func _on_wpbuystormi_body_entered(body):

	if body.has_method("addweapon"):
		body.addweapon(weapons)

