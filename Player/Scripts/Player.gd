extends "res://References/NodeReference.gd"

var PlayerStateMachine = load("res://Player/PlayerStateMachine.gd").new()

func _ready():
	add_child(PlayerStateMachine)
	set_process_input(true)
	
func _input(event):
	if (get_tree().is_paused()): return
	if (event.is_action_pressed("key_inventory")):
		if (PlayerStateMachine.current_state != "inventory"):
			PlayerInventory.show()
			PlayerStateMachine.current_state = "inventory"
		else:
			PlayerInventory.hide()
			PlayerStateMachine.current_state = PlayerStateMachine.last_state