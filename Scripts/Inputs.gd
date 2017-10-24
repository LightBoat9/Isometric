# Tracks and stores user input
extends Node

var key_left = 0 setget , get_key_left
var key_right = 0 setget , get_key_right
var key_up = 0 setget , get_key_up
var key_down = 0 setget , get_key_down

var key_shield = 0 setget , get_key_shield

var mouse_left = 0 setget , get_mouse_left

func _ready():
	set_process(true)

func _process(delta):
	# Keyboard
	key_left = Input.is_action_pressed("key_left")
	key_right = Input.is_action_pressed("key_right")
	key_up = Input.is_action_pressed("key_up")
	key_down = Input.is_action_pressed("key_down")
	key_shield = Input.is_action_pressed("key_shield")
	
	# Mouse
	mouse_left = Input.is_action_pressed("mouse_left")
	
func get_key_left():
	return key_left
	
func get_key_right():
	return key_right
	
func get_key_up():
	return key_up
	
func get_key_down():
	return key_down
	
func get_key_shield():
	return key_shield

# Mouse	
func get_mouse_left():
	return mouse_left