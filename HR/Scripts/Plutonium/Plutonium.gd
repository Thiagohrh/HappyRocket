extends Area2D

signal death(_self)

func _ready():
	add_to_group("plutonium")
	pass

func _process(delta):
	pass


func _on_Plutonium_body_entered(body):
	if body.is_in_group("starship"):
		emit_signal("death", self)
		body.change_behaviour(2, null)
		queue_free()
	pass # replace with function body
