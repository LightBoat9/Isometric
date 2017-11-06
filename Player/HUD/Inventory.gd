extends Node2D

onready var BackpackSprite = get_node("BackpackSprite")

var bp_tex_closed = load("res://Player/HUD/Textures/Backpack/0.png")
var bp_tex_open = load("res://Player/HUD/Textures/Backpack/1.png")

func _ready():
	set_process_input(true)

func _input(event):
	if (event.type == InputEvent.MOUSE_MOTION):
		if _is_mouse_over(event):
			BackpackSprite.set_texture(bp_tex_open)
		else:
			BackpackSprite.set_texture(bp_tex_closed)
	
func _is_mouse_over(event):
	return (
		event.pos.x - get_global_pos().x < 30 && 
		event.pos.x - get_global_pos().x > 0 &&
		event.pos.y - get_global_pos().y < 30 && 
		event.pos.y - get_global_pos().y > 0
		)
