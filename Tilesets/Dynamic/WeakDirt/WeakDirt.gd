extends "res://Enemies/Enemy.gd"

func destroy():
	randomize()
	drop_coin(int(rand_range(0,2.99)))
	queue_free()
