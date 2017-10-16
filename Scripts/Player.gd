extends KinematicBody2D

var key_left = 0
var key_right = 0
var key_up = 0
var key_down = 0

var movespeed = 50

var velocity = Vector2()

var jump_offset = Vector2()
var jump_power = 1

func _ready():
	set_process_input(true)
	set_process(true)

func _process(delta):
	_inputs()
	_velocity_from_input()
	move(cartesian_to_isometric(velocity).normalized())
	print(cartesian_to_isometric(velocity).normalized())

func _inputs():
	key_left = Input.is_action_pressed("key_left")
	key_right = Input.is_action_pressed("key_right")
	key_up = Input.is_action_pressed("key_up")
	key_down = Input.is_action_pressed("key_down")
	
func _velocity_from_input():
	var h = key_right - key_left
	var v = key_down - key_up
	velocity.x = h
	velocity.y = v
	
func cartesian_to_isometric(cartesian):
	return Vector2(cartesian.x - cartesian.y, (cartesian.x + cartesian.y) / 2)