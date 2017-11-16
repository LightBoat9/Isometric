extends "res://References/NodeReference.gd"

onready var Shield = Player.get_node("Shield")

var M1Timer = create_basic_timer(0.5, true, true)
var M1Charge = create_basic_timer(2.0, true, false)

var Fireball = load("res://Player/Spells/PlayerFireball.tscn")

func _ready():
	set_process_input(true)
	set_process(true)
	
func _input(event):
	if (Player.StateMachine.current_state == "menu"): return
	if (Player.StateMachine.current_state == "inventory"): return
	if (event.is_action_pressed("mouse_left")):
		Player.StateMachine.current_state = "charge"
		M1Charge.start()
	elif (event.is_action_released("mouse_left") && M1Timer.get_time_left() == 0):
		Player.StateMachine.current_state = Player.StateMachine.last_state
		var inst = Fireball.instance()
		inst.set_pos(Vector2(Player.get_pos().x, Player.get_pos().y + 7.5))
		inst.power = 2.0 - M1Charge.get_time_left() / M1Charge.get_wait_time()
		Walls.add_child(inst)
		M1Timer.start()
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
	update_hud()
	
func update_hud():
	PlayerHUDSpells.m1_time = M1Timer.get_time_left()
	
func create_basic_timer(time, oneshot, autostart):
	var inst = Timer.new()
	inst.set_wait_time(time)
	inst.set_one_shot(oneshot)
	inst.set_autostart(autostart)
	add_child(inst)
	return inst