extends Node2D
const CIRCLE_DISTANCE = Vector2(25,0)
export var CIRCLE_RADIUS = 50

var alignment = Vector2(1, 0)
var displacement

func _ready():
	randomize()
	displacement = alignment * CIRCLE_RADIUS
	displacement.rotated(randf())
	var wander_force = CIRCLE_DISTANCE + displacement
	pass

func _process(delta):
	pass

func get_random_wander_force():
	displacement = global_position - get_parent().global_position * CIRCLE_RADIUS
	displacement = displacement.rotated(randf() * PI).normalized() * 100
	print(global_rotation)
	var wander_force = global_position - get_parent().global_position + displacement
	return(wander_force)