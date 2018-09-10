extends Node

onready var HUD = get_node("HUD")
onready var rocket = get_node("StarShip")
func _ready():
	
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	pass


func _on_Seek_pressed():
	rocket.change_behaviour(0)
	pass # replace with function body


func _on_Flee_pressed():
	rocket.change_behaviour(1)
	pass # replace with function body


func _on_Wander_pressed():
	rocket.change_behaviour(2)
	pass # replace with function body
