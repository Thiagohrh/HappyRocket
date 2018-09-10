extends Node

func _ready():
	randomize()
	pass

func _process(delta):
	pass

func fire_away():
	var num = get_child_count()
	var chosen_child = get_child(randi() % num)
	chosen_child.shoot(null)
	pass

func _on_Pursuit_pressed():
	fire_away()
	pass # replace with function body
