# Enemy Slime state machine
extends "StateMachine.gd"

func _ready():
	set_current_state("idle")
	
func idle_enter(): pass
func idle_exit(): pass
func idle_update(): pass

func attack_enter(): pass
func attack_exit(): pass
func attack_update(): get_parent().SlimeAttack.update()