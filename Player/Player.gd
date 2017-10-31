extends "res://References/StateMachine.gd"

onready var Save = get_node("HUD/Save")

func _ready():
	Save.connect("button_down", self, "save_game")
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
			
func save_game():
	Global.save_game()