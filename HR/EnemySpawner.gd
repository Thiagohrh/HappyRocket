extends "res://Scripts/Canon.gd"

export (bool) var random_speed = false

func shoot():
	if direction != null:
		var new_monster = spawn_object.instance()
		new_monster.position = Vector2(0,0)
		$BulletContainer.add_child(new_monster)
		if random_speed:
			speed = randi() % speed + 50
			pass
		new_monster.start(direction, speed)
	pass