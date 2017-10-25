extends "NodeReference.gd"

onready var MouseArea = get_node("MouseArea")
onready var StairsSprite = get_node("StairsSprite")

var mouse_over = false

func _ready():
	MouseArea.connect("body_enter", self, "player_enter")
	MouseArea.connect("body_exit", self, "player_exit")

func player_enter(body):
	if (body != Player): return
	get_node("/root/Global").goto_scene("res://Scenes/Level2.tscn")

func player_exit(body):
	if (body != Player): return