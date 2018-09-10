extends Node

export (PackedScene) var Plutonium
onready var spawn_position = get_node("SpawnPosition")

var time_to_spawn

func _ready():
	time_to_spawn = get_node("TimeToSpawn")
	randomize()
	
	if time_to_spawn.is_stopped():
		time_to_spawn.start()
	pass

func _process(delta):
	pass


func _on_TimeToSpawn_timeout():
	#Should Spawn a plutonium
	var new_plutonium = Plutonium.instance()
	new_plutonium.global_position = spawn_position.global_position
	new_plutonium.global_position.x = new_plutonium.global_position.x + randi() % 800 - 400
	new_plutonium.global_position.y = new_plutonium.global_position.y + randi() % 500 - 250
	add_child(new_plutonium)
	pass