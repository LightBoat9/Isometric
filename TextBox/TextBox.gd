# A TextBox that displays strings from an array
extends "res://References/NodeReference.gd"

# TextBox Nodes
onready var Picture = get_node("Picture")
onready var BoxLabel = get_node("BoxLabel")
onready var LetterTimer = get_node("LetterTimer")

var Creator # Holds a reference to this objects instancer

var text = ""
var text_array = []
var text_index = 0
var text_done = false

func _ready():
	LetterTimer.connect("timeout", self, "add_letter")
	
func setup(Creator, text_array):
	text = ""
	BoxLabel.set_text(text)
	self.Creator = Creator
	self.text_array = text_array
	set_process_input(true)
	
func _input(event):
	if (event.is_action_pressed("mouse_left")):
		if (text_done):
			if (text_index < text_array.size() - 1): 
				text_index += 1
				text = ""
				text_done = false
			else: complete(true)
		else:
			text = ""
			for i in text_array[text_index]:
				text += i
			BoxLabel.set_text(text)
			text_done = true
	if (event.is_action_pressed("key_escape")): complete(false)
	
func set_picture(pic):
	Picture.set_texture(pic)
	Picture.set_scale(Vector2(3, 3))
	Picture.set_pos(Vector2(-Picture.get_texture().get_size().x / 2, Picture.get_texture().get_size().y / 6))
	
func add_letter():
	if (text_array[text_index].length() == text.length()):
		text_done = true
		return
	text += text_array[text_index][text.length()]
	BoxLabel.set_text(text)
	
func complete(is_done):
	Player.StateMachine.current_state = Player.StateMachine.last_state
	Creator.text_box = null
	if (is_done): Creator.dialogue_read()
	text = ""
	text_index = 0
	text_done = false
	queue_free()