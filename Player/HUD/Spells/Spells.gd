extends "res://References/NodeReference.gd"

onready var M1Shade = get_node("M1Shade")
onready var M1Sprite = get_node("M1Sprite")
onready var M1Time = get_node("M1Time")

var m1_time = 0.0 setget set_m1_time

func set_m1_time(value):
	M1Sprite.show()
	if (value == 0.0):
		M1Shade.hide()
		M1Time.hide()
	else:
		M1Shade.show()
		M1Time.show()
		
	if (value < 1):
		M1Time.set_text(str(round(value*10)/10))
	else:
		M1Time.set_text(str(int(value)))