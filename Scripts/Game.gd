extends Node2D

func _ready():
	set_process_input(true)

func _input(event):
	if (event.type == InputEvent.KEY && event.pressed && event.scancode == KEY_F):
		OS.set_window_fullscreen(!OS.is_window_fullscreen())