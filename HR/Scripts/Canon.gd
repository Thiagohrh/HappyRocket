extends Area2D

export (PackedScene) var spawn_object
export (String, "up", "down", "left", "right", "upright", "upleft", "downright", "downleft") var shoot_direction
export (int) var speed = null
var direction = null

func _ready():
	if shoot_direction == "up":
		direction = Vector2(0,-1)
	elif shoot_direction == "down":
		direction = Vector2(0,1)
	elif shoot_direction == "left":
		direction = Vector2(-1,0)
	elif shoot_direction == "right":
		direction = Vector2(1,0)
	elif shoot_direction == "upright":
		direction = Vector2(1, -1)
	elif shoot_direction == "upleft":
		direction = Vector2(-1, -1)
	elif shoot_direction == "downright":
		direction = Vector2(1, 1)
	elif shoot_direction == "downleft":
		direction = Vector2(-1, 1)
	else:
		print("Remember to set the direction properly.")
	pass

func shoot(_target):
	if direction != null:
		var new_bullet = spawn_object.instance()
		new_bullet.position = Vector2(0,0)
		$BulletContainer.add_child(new_bullet)
		new_bullet.start(direction, _target)
	pass

func _process(delta):
	pass
