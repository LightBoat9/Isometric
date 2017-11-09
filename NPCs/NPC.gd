extends "res://References/NodeReference.gd"

# NPC Nodes
onready var MouseArea = get_node("MouseArea")
onready var NPCSprite = get_node("NPCSprite")
onready var NPCDialogue = get_node("NPCDialogue")

var TextBox = load("res://TextBox/TextBox.tscn")

var mouse_over = false

var text_array = []
var last_text_array = []
var text_box = null

func _ready():
	MouseArea.connect("mouse_enter", self, "mouse_enter")
	MouseArea.connect("mouse_exit", self, "mouse_exit")
	
	set_process_input(true)
	
func _input(event):
	if (event.type == InputEvent.MOUSE_MOTION):
		if (_mouse_is_over()):
			mouse_over = true
			NPCSprite.get_material().set_shader_param("visible", 1)
		else:
			NPCSprite.get_material().set_shader_param("visible", 0)
			mouse_over = false
	elif (event.is_action_pressed("mouse_left")):
		if (mouse_over):
			if (text_box == null):
				Player.StateMachine.current_state = "menu"
				spawn_text_box()
			
func _mouse_is_over():
	var h = NPCSprite.get_texture().get_height()
	var w = NPCSprite.get_texture().get_width()
	return (
		NPCSprite.get_global_mouse_pos().x - get_global_pos().x < w && 
		NPCSprite.get_global_mouse_pos().x - get_global_pos().x > 0 &&
		NPCSprite.get_global_mouse_pos().y - get_global_pos().y < h && 
		NPCSprite.get_global_mouse_pos().y - get_global_pos().y > 0
		)
	
func spawn_text_box():
	text_box = TextBox.instance()
	Game.add_child(text_box)
	text_box.setup(self, text_array)
	text_box.set_picture(NPCSprite.get_texture())
	
func dialogue_read():
	NPCDialogue.hide()
	text_array = last_text_array