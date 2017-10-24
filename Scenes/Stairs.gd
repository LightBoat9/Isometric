extends "NodeReference.gd"

onready var MouseArea = get_node("MouseArea")
onready var StairsSprite = get_node("StairsSprite")

var selected = load("res://Textures/block_stairs_selected.png")
var not_selected = load("res://Textures/block_stairs.png")

var mouse_over = false

func _ready():
	MouseArea.connect("mouse_enter", self, "ma_enter")
	MouseArea.connect("mouse_exit", self, "ma_exit")
	MouseArea.connect("body_enter", self, "player_enter")
	MouseArea.connect("body_exit", self, "player_exit")
	
func ma_enter():
	mouse_over = true
	
func ma_exit():
	StairsSprite.set_texture(not_selected)
	mouse_over = false

func player_enter(body):
	print(body)
	if (body != Player): return
	StairsSprite.set_texture(selected)

func player_exit(body):
	if (body != Player): return
	StairsSprite.set_texture(not_selected)

	