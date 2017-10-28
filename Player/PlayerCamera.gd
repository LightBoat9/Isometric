extends "res://References/NodeReference.gd"

var zoom = get_zoom()
var zoom_speed = 0.1
var min_zoom = 0.5
var max_zoom = 1

func _ready():
	set_process_input(true)
	
func _input(event):
	if (event.is_action_pressed("mouse_wheel_up")):
		if (zoom.x > min_zoom): zoom = Math.addv(zoom, -zoom_speed)
		else: zoom = Vector2(min_zoom, min_zoom)
	if (event.is_action_pressed("mouse_wheel_down")):
		if (zoom.x < max_zoom): zoom = Math.addv(zoom, zoom_speed)
		else: zoom = Vector2(max_zoom, max_zoom)
	if (event.is_action_pressed("mouse_middle")):
		zoom = Vector2(max_zoom, max_zoom)
	set_zoom(zoom)
