extends "NodeReference.gd"

var movespeed = 50
var velocity = Vector2() setget , get_velocity

# Updates when not zero
var direction = Vector2() setget set_direction, get_direction

func _ready():
	set_process(true)
	
func _process(delta):
	_velocity_from_input()
	set_direction(velocity)
	Player.move(velocity)
	
# Get the velocity based on input and movement speed
func _velocity_from_input():
	var h = Inputs.key_right - Inputs.key_left
	var v = Inputs.key_down - Inputs.key_up
	velocity.x = h * movespeed * get_process_delta_time()
	velocity.y = v * movespeed * get_process_delta_time()
	
func get_velocity():
	return velocity
	
func set_direction(value):
	if (value.x != 0): direction.x = sign(value.x)
	if (value.y != 0): direction.y = sign(value.y)
	
func get_direction():
	return direction