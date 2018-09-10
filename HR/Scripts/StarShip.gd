extends KinematicBody2D

enum STATES{ seek, flee, wander }

var current_state = STATES.wander

const MAX_SPEED = 300
const MAX_FORCE = 0.02
const WANDER_RING_DISTANCE = 250
const WANDER_RING_RADIUS = 500
var velocity = Vector2(0,0)

var target = null

var arrival_b = true
var arriving_radius = 100
var circle_target

signal saw_this(object)
signal successful_escape()

func _ready():
	add_to_group("starship")
	var custom_circle_position = global_position + velocity.normalized() * WANDER_RING_DISTANCE
	circle_target = custom_circle_position + Vector2(WANDER_RING_RADIUS, 0).rotated(randi(0,360))
	pass

func _process(delta):
	if current_state == STATES.seek and target != null:
		#target = get_global_mouse_position()
		velocity = steer(target)
		rotation = velocity.angle()# + 0.5 * PI
		move_and_slide(velocity)
		pass
	elif current_state == STATES.flee and target != null:
		#target = get_global_mouse_position()
		velocity = flee(target)
		rotation = velocity.angle()# + 0.5 * PI
		move_and_slide(velocity)
		if global_position.distance_to(target.global_position) > 300:
			emit_signal("successful_escape")
		pass
	elif current_state == STATES.wander:
		velocity = wander()
		rotation = velocity.angle()# + 0.5 * PI
		move_and_slide(velocity)
		pass
	else:
		print("You did something wrong.")
	pass

func steer(target):
	var desired_velocity = target.global_position - global_position
	var distance = desired_velocity.length()
	if arrival_b:
		if distance < arriving_radius:
			desired_velocity = desired_velocity.normalized() * MAX_SPEED * (distance/arriving_radius)
			pass
		else:
			desired_velocity = desired_velocity.normalized() * MAX_SPEED
			pass
		pass
	else:
		desired_velocity = desired_velocity.normalized() * MAX_SPEED
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * MAX_FORCE)
	return(target_velocity)

func flee(target):
	var desired_velocity = Vector2(global_position - target.global_position).normalized() * MAX_SPEED
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * MAX_FORCE)
	return(target_velocity)

func wander():
	#circle_target = custom_circle_position + Vector2(WANDER_RING_RADIUS, 0).rotated(randi(0,360))
	var desired_velocity = circle_target - global_position
	desired_velocity = desired_velocity.normalized() * MAX_SPEED
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * MAX_FORCE)
	return(target_velocity)
	pass

func change_behaviour(steering_behaviour, _target):
	target = _target
	current_state = steering_behaviour
	pass


func _on_WanderStable_timeout():
	var custom_circle_position = global_position + velocity.normalized() * WANDER_RING_DISTANCE
	circle_target = custom_circle_position + Vector2(WANDER_RING_RADIUS, 0).rotated(randi(0,360))
	pass # replace with function body

func get_velocity():
	return(velocity)

func get_state():
	return(current_state)

func set_target(_target):
	target = _target

func escaped_target(_object):
	current_state = STATES.wander
	target = null

func _on_FieldOfView_area_entered(area):
	#Should just emit a signal that sends what has been seen. Let Mother Brain figure out what it needs to do.
	emit_signal("saw_this", area)
	pass