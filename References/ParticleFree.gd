extends "res://References/NodeReference.gd"

var free_timer

func _ready():
	set_emitting(true)
	initialize_free_timer()
	
func initialize_free_timer():
	free_timer = Timer.new()
	free_timer.set_one_shot(true)
	free_timer.set_wait_time(1)
	free_timer.connect("timeout", self, "free_timeout")
	free_timer.start()
	add_child(free_timer)
	
func free_timeout():
	queue_free()
