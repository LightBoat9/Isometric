extends "res://References/NodeReference.gd"

onready var Picture = get_node("Picture")
onready var Text = get_node("Text")
onready var LetterTimer = get_node("LetterTimer")

var Creator

var text = "" setget set_text, get_text
var text_array = []
var text_index = 0
var text_done = false

func _ready():
	LetterTimer.connect("timeout", self, "add_letter")
	
func init(Creator, text_array):
	Text.set_text("")
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
			else: complete()
	if (event.is_action_pressed("key_escape")): complete()

func set_picture(pic):
	Picture.set_texture(pic)
	Picture.set_scale(Vector2(3, 3))
	Picture.set_pos(Vector2(-Picture.get_texture().get_size().x / 2, Picture.get_texture().get_size().y / 6))
	
func add_letter():
	if (text_array[text_index].length() == text.length()):
		text_done = true
		return
	text += text_array[text_index][text.length()]
	Text.set_text(text)
	
func set_text(value):
	text = value

func get_text():
	return text
	
func complete():
	PlayerStateMachine.current_state = PlayerStateMachine.last_state
	Creator.text_box = null
	Creator.dialogue_read()
	text = ""
	text_index = 0
	text_done = false
	queue_free()