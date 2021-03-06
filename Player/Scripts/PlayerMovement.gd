extends "res://References/NodeReference.gd"

var movespeed = 10.0
var max_speed = 1.0

var velocity = Vector2() setget , get_velocity
var remainder

# Updates when not zero
var direction = Vector2() setget , get_direction
	
func update():
	_velocity_from_input()
	_set_direction(velocity)
	remainder = Player.move(velocity)
	_collision()
	
# Get the velocity based on input and movement speed
func _velocity_from_input():
	var h = Inputs.key_right - Inputs.key_left
	var v = Inputs.key_down - Inputs.key_up
	if (h != 0 && v != 0):
		velocity.x = lerp(velocity.x, max_speed * h, movespeed * get_process_delta_time())
		velocity.y = lerp(velocity.y, max_speed * v/2, movespeed * get_process_delta_time())
	else:
		if (h != 0):
			velocity.x = lerp(velocity.x, max_speed * h, movespeed * get_process_delta_time())
		else:
			velocity.x = lerp(velocity.x, 0, movespeed * get_process_delta_time())
		if (v != 0):
			velocity.y = lerp(velocity.y, max_speed * v, movespeed * get_process_delta_time())
		else:
			velocity.y = lerp(velocity.y, 0, movespeed * get_process_delta_time())
	
func _collision():
	if (Player.is_colliding()):
		var c = Player.get_collider()
		if (c == null): return
		
		var n = Player.get_collision_normal()
		remainder = n.slide(remainder)
		Player.move(remainder)
	
func get_velocity():
	return velocity
	
func knock_back(dir, force):
	velocity = dir * force
	
func _set_direction(value):
	if (value.x != 0): direction.x = sign(value.x)
	if (value.y != 0): direction.y = sign(value.y)
	
func get_direction():
	return direction