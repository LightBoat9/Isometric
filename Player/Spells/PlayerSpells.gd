extends "res://References/NodeReference.gd"

onready var Shield = Player.get_node("Shield")

var Fireball = load("res://Player/Spells/PlayerFireball.tscn")

var m1_active = false

func _ready():
	set_process_input(true)
	set_process(true)
	
func _input(event):
	if (Player.StateMachine.current_state == "menu"): return
	if (Player.StateMachine.current_state == "inventory"): return
	"""
	if (event.is_action_pressed("key_shield")):
		if (Shield.is_visible()):
			Shield.hide()
		else:
			Shield.show()
	"""
			
func _process(delta):
	if (Player.StateMachine.current_state == "menu"): return
	if (Player.StateMachine.current_state == "inventory"): return
	use_m1()
	
func use_m1():
	if (!m1_active): return
	PlayerHUDSpells.m1_time = Player.M1Timer.get_time_left()
	if (Input.is_action_pressed("mouse_left") && Player.M1Timer.get_time_left() == 0):
		var inst = Fireball.instance()
		inst.set_pos(Vector2(Player.get_pos().x, Player.get_pos().y + 7.5))
		Walls.add_child(inst)
		Player.M1Timer.start()
