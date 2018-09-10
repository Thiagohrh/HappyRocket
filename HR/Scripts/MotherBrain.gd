extends Node
export (PackedScene) var emote_machine
var emotes = null

var starship = null

enum STATES{ seek, flee, wander }
enum ANIMATIONS{ hmm, no1, rice, swt, shit, diz}

var current_state = STATES.wander

var plutonium_list = Array()
var enemy_list = Array()

func _ready():
	if starship == null:
		starship = get_tree().get_nodes_in_group("starship")
		starship = starship[0]
		starship.connect("saw_this", self, "saw_something")
		starship.connect("successful_escape", self, "successful_escape")
		
		#For the emotes:
		var new_emote_machine = emote_machine.instance()
		add_child(new_emote_machine)
		new_emote_machine.set_up_ship(starship)
		emotes = new_emote_machine
	pass

func _process(delta):
	if !enemy_list.empty() and starship.get_state() != STATES.flee:
		starship.change_behaviour(STATES.flee, enemy_list.front())
		enemy_list.front().connect("death", starship, "escaped_target")
		pass
	elif !plutonium_list.empty() and starship.get_state() == STATES.wander:
		starship.change_behaviour(STATES.seek, plutonium_list.front())
		pass
	pass

func saw_something(object):
	if object.is_in_group("enemy"):
		#Should do seek
		if !enemy_list.has(object):
			enemy_list.push_back(object)
			object.connect("death", self, "something_dies")
			emotes.play_animation(ANIMATIONS.shit)
			#print(enemy_list.size())
			pass
		pass
	elif object.is_in_group("plutonium"):
		#Should do avoid
		if !plutonium_list.has(object):
			if randi() % 2:
				emotes.play_animation(ANIMATIONS.rice)
			plutonium_list.push_back(object)
			object.connect("death", self, "something_dies")
			#print(plutonium_list.size())
		pass
	else:
		#print("Dunno what i saw man")
		pass
	pass

func something_dies(object):
	if object.is_in_group("plutonium"):
		plutonium_list.remove(plutonium_list.find(object))
		if randi() % 2:
			emotes.play_animation(ANIMATIONS.no1)
	if object.is_in_group("enemy"):
		if enemy_list.has(object):
			enemy_list.remove(enemy_list.find(object))
			pass
		pass

func successful_escape():
	emotes.play_animation(ANIMATIONS.hmm)
	enemy_list.clear()
	starship.escaped_target(null)