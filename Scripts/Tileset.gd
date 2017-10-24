extends "Enemy.gd"

func damage(amount):
	destroy()

func destroy():
	queue_free()
