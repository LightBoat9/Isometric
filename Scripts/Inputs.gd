# Tracks and stores user input
extends Node

var key_left = 0 setget , get_key_left
var key_right = 0 setget , get_key_right
var key_up = 0 setget , get_key_up
var key_down = 0 setget , get_key_down

var key_left_pressed = 0 setget , get_key_left_pressed
var key_right_pressed = 0 setget , get_key_right_pressed
var key_up_pressed = 0 setget , get_key_up_pressed
var key_down_pressed = 0 setget , get_key_down_pressed

var mouse_left = 0 setget , get_mouse_left

var mouse_left_pressed = 0 setget , get_mouse_left_pressed

func _ready():
	set_process_input(true)
	set_process(true)
	
func _input(event):
	# Keyboard
	key_left_pressed = event.is_action_pressed("key_left")
	key_right_pressed = event.is_action_pressed("key_right")
	key_up_pressed = event.is_action_pressed("key_up")
	key_down_pressed = event.is_action_pressed("key_down")
	
	# Mouse
	mouse_left_pressed = event.is_action_pressed("mouse_left")

func _process(delta):
	# Keyboard
	key_left = Input.is_action_pressed("key_left")
	key_right = Input.is_action_pressed("key_right")
	key_up = Input.is_action_pressed("key_up")
	key_down = Input.is_action_pressed("key_down")
	
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
	
func get_key_left_pressed():
	return key_left_pressed
	
func get_key_right_pressed():
	return key_right_pressed
	
func get_key_up_pressed():
	return key_up_pressed
	
func get_key_down_pressed():
	return key_down_pressed
	
func get_mouse_left():
	return mouse_left
	
func get_mouse_left_pressed():
	return mouse_left_pressed