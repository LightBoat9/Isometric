# Dirt block that breaks when hit
extends "Enemy.gd"

func damage(amount):
	destroy()

func destroy():
	queue_free()
