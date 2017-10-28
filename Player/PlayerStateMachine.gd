extends "res://References/StateMachine.gd"

func _ready():
	set_current_state("idle")
	
func idle_enter(): pass
func idle_exit(): pass
func idle_update(): 
	if (Inputs.key_left || Inputs.key_right || 
		Inputs.key_up || Inputs.key_down):
		set_current_state("move")
		
	PlayerMovement.update()
		
func move_enter(): pass
func move_exit(): pass
func move_update():
	if (!Inputs.key_left && !Inputs.key_right &&
		!Inputs.key_up && !Inputs.key_down):
		set_current_state("idle")
	
	PlayerMovement.update()

func menu_enter(): get_tree().set_pause(true)
func menu_exit(): get_tree().set_pause(false)
func menu_update(): pass