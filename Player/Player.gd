extends "res://References/StateMachine.gd"

func _ready():
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