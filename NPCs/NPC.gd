extends "res://References/NodeReference.gd"

# NPC Nodes
onready var MouseArea = get_node("MouseArea")
onready var NPCHighlight = get_node("NPCHighlight")
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
	if (event.is_action_pressed("mouse_left")):
		if (mouse_over):
			if (text_box == null):
				Player.StateMachine.current_state = "menu"
				spawn_text_box()
	
func mouse_enter():
	mouse_over = true
	NPCHighlight.show()
	
func mouse_exit():
	mouse_over = false
	NPCHighlight.hide()
	
func spawn_text_box():
	text_box = TextBox.instance()
	Game.add_child(text_box)
	text_box.setup(self, text_array)
	text_box.set_picture(NPCSprite.get_texture())
	
func dialogue_read():
	NPCDialogue.hide()
	text_array = last_text_array