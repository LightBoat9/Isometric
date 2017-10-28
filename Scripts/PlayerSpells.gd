extends "NodeReference.gd"

onready var Shield = Player.get_node("Shield")

var Fireball = load("res://Scenes/PlayerFireball.tscn")

var m1_timer
var m1_cooldown = 1.0/2.0

func _ready():
	create_timers()
	set_process_input(true)
	set_process(true)
	
func _input(event):
	if (PlayerStateMachine.current_state == "menu"): return
	if (event.is_action_pressed("key_shield")):
		if (Shield.is_visible()):
			Shield.hide()
		else:
			Shield.show()
			
func _process(delta):
	if (PlayerStateMachine.current_state == "menu"): return
	PlayerHUDSpells.m1_time = m1_timer.get_time_left()
	if (Input.is_action_pressed("mouse_left") && m1_timer.get_time_left() == 0):
		use_m1()
	
func create_timers():
	m1_timer = Timer.new()
	m1_timer.set_wait_time(m1_cooldown)
	m1_timer.set_one_shot(true)
	m1_timer.start()
	add_child(m1_timer)
	
func use_m1():
	var inst = Fireball.instance()
	inst.set_pos(Vector2(Player.get_pos().x, Player.get_pos().y + 7.5))
	Walls.add_child(inst)
	m1_timer.start()
