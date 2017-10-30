extends "res://References/StateMachine.gd"

onready var Save = get_node("HUD/Save")

func _ready():
	Save.connect("button_down", self, "save_game")
	set_process_input(true)
	
func _input(event):
	if (event.is_action_pressed("key_inventory")):
		if (PlayerStateMachine.current_state != "menu"):
			get_tree().set_pause(true)
			PlayerInventory.show()
			PlayerStateMachine.current_state = "menu"
		else:
			get_tree().set_pause(false)
			PlayerInventory.hide()
			PlayerStateMachine.current_state = PlayerStateMachine.last_state
			
func save_game():
	Global.save_game()
	
func load_game(data):
	# Update Position
	set_pos(Vector2(float(data["player_pos_x"]), float(data["player_pos_y"])))
	
	# Update Spells
	get_node("PlayerSpells").set_m1_active(data["m1_active"])