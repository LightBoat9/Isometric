extends "res://References/NodeReference.gd"

onready var Shield = Player.get_node("Shield")
onready var M1Timer = get_node("M1Timer")

var Fireball = load("res://Player/Spells/PlayerFireball.tscn")

var m1_active = false setget set_m1_active, get_m1_active

func _ready():
	set_process_input(true)
	set_process(true)
	
func _input(event):
	if (PlayerStateMachine.current_state == "menu"): return
	if (PlayerStateMachine.current_state == "inventory"): return
	"""
	if (event.is_action_pressed("key_shield")):
		if (Shield.is_visible()):
			Shield.hide()
		else:
			Shield.show()
	"""
			
func _process(delta):
	if (PlayerStateMachine.current_state == "menu"): return
	if (PlayerStateMachine.current_state == "inventory"): return
	use_m1()
	
func set_m1_active(value):
	m1_active = value
	
func get_m1_active():
	return m1_active
	
func use_m1():
	if (!m1_active): return
	PlayerHUDSpells.m1_time = M1Timer.get_time_left()
	if (Input.is_action_pressed("mouse_left") && M1Timer.get_time_left() == 0):
		var inst = Fireball.instance()
		inst.set_pos(Vector2(Player.get_pos().x, Player.get_pos().y + 7.5))
		Walls.add_child(inst)
		M1Timer.start()
	
func load_game(data):
	m1_active = data["player_m1_active"]
