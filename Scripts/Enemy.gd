# Base script for all enemies
extends "NodeReference.gd"

func _ready():
	add_to_group("Enemies")
	
func damage():
	print("ERROR: method not implemented | damage()")
	
func destroy():
	print("ERROR: method not implemented | destroy()")
