extends Node

onready var spawn_time = get_node("SpawnEnemyTime")
onready var spawners = get_node("Spawners")

export (int) var max_enemy_number = 1

func _ready():
	randomize()
	if spawn_time.is_stopped():
		spawn_time.start()
	pass

func _process(delta):
	pass

func fire_away():
	var num = spawners.get_child_count()
	var chosen_child = spawners.get_child(randi() % num)
	chosen_child.shoot()
	pass

func _on_Pursuit_pressed():
	fire_away()
	pass # replace with function body


func _on_SpawnEnemyTime_timeout():
	var enemy_instances = get_tree().get_nodes_in_group("enemy")
	if enemy_instances.size() < max_enemy_number:
		fire_away()
	pass # replace with function body
