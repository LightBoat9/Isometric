# Dirt block that breaks when hit
extends "res://Enemies/Enemy.gd"

func damage(amount):
	destroy()

func destroy():
	queue_free()
