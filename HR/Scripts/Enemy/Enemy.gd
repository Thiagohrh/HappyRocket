extends Area2D

signal death(_self)

var direction = Vector2()
var speed = 300
var alive = false

func _ready():
	add_to_group("enemy")
	$AnimationPlayer.play("Idle")
	pass

func _process(delta):
	if alive:
		global_position = global_position + direction * speed * delta
		#Should just move from one end to the other end of the screen
		self_destruct_check()
		pass
	pass

func self_destruct_check():
	#If this checks true, start proceedings to self destruct.
	#print(get_viewport().size)
	if global_position.x > get_viewport().size.x + 300 or global_position.x < -300 or global_position.y > get_viewport().size.y + 300 or global_position.y < -300:
		emit_signal("death", self)
		queue_free()
		pass
	
	pass

func start(_direction, _speed):
	direction = _direction
	if _speed != null:
		speed = _speed
		pass
	alive = true
	pass

func _on_Enemy_body_entered(body):
	if body.is_in_group("starship"):
		print("Have found a player yeh?")
		pass
	pass # replace with function body
