# The entrance to the next level
extends "res://References/NodeReference.gd"

onready var MouseArea = get_node("MouseArea")
onready var StairsSprite = get_node("StairsSprite")

var mouse_over = false

func _ready():
	MouseArea.connect("body_enter", self, "player_enter")

func player_enter(body):
	if (body != Player): return
	Global.save_game()
	var lvl = int(Global.get_level()) + 1
	Global.goto_scene("res://Levels/Level" + str(lvl) + ".tscn")