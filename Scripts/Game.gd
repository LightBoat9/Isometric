# Base node for the game
extends "NodeReference.gd"

func _ready():
	set_process_input(true)
	set_process(true)

func _input(event):
	# Toggle fullscreen
	if (event.type == InputEvent.KEY && event.pressed && event.scancode == KEY_F):
		OS.set_window_fullscreen(!OS.is_window_fullscreen())