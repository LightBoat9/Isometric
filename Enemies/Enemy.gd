# Base script for all enemies
extends "res://References/NodeReference.gd"

var Coin = load("res://Drops/Coin/Coin.tscn")

func _ready():
	add_to_group("Enemies")
	
func damage():
	pass
	
func destroy():
	pass
	
func drop_coin():
	var inst = Coin.instance()
	inst.set_pos(get_pos())
	Coins.add_child(inst)