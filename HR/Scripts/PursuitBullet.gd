extends Area2D

var target = null
var motion = null
const MAX_SPEED = 300
const MAX_FORCE = 0.02

var velocity = Vector2(0,0)

var speed = 250

func _ready():
	add_to_group("pursuit_bullet")
	target = get_tree().get_nodes_in_group("starship")
	target = target[0]
	pass

func _process(delta):
	if motion != null and target == null:
		global_position = global_position + motion * delta * speed
		rotation = motion.angle()
		pass
	if motion != null and target != null:
		motion = pursuit()
		global_position = global_position + motion * delta * MAX_SPEED * 0.1
		rotation = motion.angle() + 1 * PI
		pass
	pass

func pursuit():
	var desired_velocity = target.global_position - global_position
	var distance = desired_velocity.length()
	
	desired_velocity = desired_velocity.normalized() * MAX_SPEED + target.get_velocity()
	
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * MAX_FORCE)
	return(target_velocity)


func start(_direction, _target):
	motion = _direction
	if _target == null:
		pass
	pass

func _on_TimeToDie_timeout():
	queue_free()
	pass 

func _on_PursuitBullet_body_entered(body):
	if body.is_in_group("starship"):
		queue_free()
	pass # replace with function body
