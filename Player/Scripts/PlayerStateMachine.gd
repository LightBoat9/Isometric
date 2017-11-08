extends "res://References/StateMachine.gd"

func _ready():
	set_current_state("idle")
	
func idle_enter(): pass
func idle_exit(): pass
func idle_update(): 
	if (Inputs.key_left || Inputs.key_right || 
		Inputs.key_up || Inputs.key_down):
		set_current_state("move")
		
	Player.Movement.update()
		
func move_enter(): pass
func move_exit(): pass
func move_update():
	if (!Inputs.key_left && !Inputs.key_right &&
		!Inputs.key_up && !Inputs.key_down):
		set_current_state("idle")
	
	Player.Movement.update()

func menu_enter(): get_tree().set_pause(true)
func menu_exit(): get_tree().set_pause(false)
func menu_update(): pass

func inventory_enter(): pass
func inventory_exit(): pass
func inventory_update(): pass