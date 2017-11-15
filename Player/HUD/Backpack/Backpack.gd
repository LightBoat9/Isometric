extends "res://References/NodeReference.gd"

onready var BackpackSprite = get_node("BackpackSprite")

var bp_tex_closed = load("res://Player/HUD/Backpack/Sprites/Sprites/0.png")
var bp_tex_open = load("res://Player/HUD/Backpack/Sprites/Sprites/1.png")

var mouse_over = false

func _ready():
	set_process_input(true)

func _input(event):
	# Toggle backpack open sprite on mouse over
	if (event.type == InputEvent.MOUSE_MOTION):
		mouse_over = _is_mouse_over(event)
		if mouse_over: 
			BackpackSprite.set_texture(bp_tex_open)
			BackpackSprite.get_material().set_shader_param("visible", 1)
		else: 
			BackpackSprite.set_texture(bp_tex_closed)
			BackpackSprite.get_material().set_shader_param("visible", 0)
	
	# Toggle inventory on mouse click
	if (event.is_action_pressed("mouse_left")):
		if (mouse_over): PlayerInventory.toggle_open()
	
# Returns if the mouse is over the backpack sprite
func _is_mouse_over(event):
	return (
		event.pos.x - get_global_pos().x < 30 && 
		event.pos.x - get_global_pos().x > 0 &&
		event.pos.y - get_global_pos().y < 30 && 
		event.pos.y - get_global_pos().y > 0
		)
