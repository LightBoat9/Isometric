extends "NodeReference.gd"

var last_state
var current_state

func get_current_state():
	return current_state
	
func set_current_state(value):
	if (current_state == value): return
	if (current_state != null): call_deferred(current_state + "_exit")
	last_state = current_state
	current_state = value
	call_deferred(current_state + "_enter")
	
func _ready():
	set_process(true)
	
func _process(delta):
	if (current_state != null):
		call_deferred(current_state + "_update")
