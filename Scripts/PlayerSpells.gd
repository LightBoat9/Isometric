extends "NodeReference.gd"

var Shield

func _ready():
	Shield = Player.get_node("Shield")
	set_process_input(true)
	
func _input(event):
	if (PlayerStateMachine.current_state == "menu"): return
	if (event.is_action_pressed("key_shield")):
		if (Shield.is_visible()):
			Shield.hide()
		else:
			Shield.show()