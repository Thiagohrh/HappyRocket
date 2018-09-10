extends Node2D

var starship = null
onready var animator = get_node("AnimationPlayer")
enum ANIMATIONS{ hmm, no1, rice, swt, shit, diz }
onready var diz_timer = get_node("Timer")

var is_lost = false

func _ready():
	play_animation(0)
	pass

func _process(delta):
	if starship != null:
		global_position.x = lerp(global_position.x, starship.global_position.x - 20, 20 * delta)
		global_position.y = lerp(global_position.y, starship.global_position.y - 20, 20 * delta)
	pass

func set_up_ship(_target):
	starship = _target
	pass

func play_animation(_index):
	if !animator.is_playing():
		if _index == ANIMATIONS.hmm:
			animator.play("hmm")
		if _index == ANIMATIONS.no1:
			animator.play("no1")
		if _index == ANIMATIONS.rice:
			animator.play("rice")
		if _index == ANIMATIONS.swt:
			animator.play("swt")
		if _index == ANIMATIONS.shit:
			animator.play("shit")
		if _index == ANIMATIONS.diz:
			animator.play("diz")
		pass
	
	if _index != ANIMATIONS.diz:
		is_lost = false
		pass
	pass

func _on_Timer_timeout():
	if is_lost == true:
		play_animation(ANIMATIONS.diz)
	else:
		is_lost = true
	pass # replace with function body
