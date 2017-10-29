# Base script for all enemies, by default an object that can be destroyed
extends "res://References/NodeReference.gd"

var Coin = load("res://Drops/Coin/Coin.tscn")
var ExplodeParticles = (
	load("res://Tilesets/Dynamic/WeakDirt/WeakDirtParticles.tscn"))

func _ready():
	add_to_group("Enemies")
	
func damage(amount, kockback_dir):
	destroy()

func destroy():
	spawn_particles()
	queue_free()
	
func drop_coin(amount):
	for i in range(amount):
		var inst = Coin.instance()
		inst.set_pos(get_pos())
		Walls.add_child(inst)
		
func spawn_particles():
	var inst = ExplodeParticles.instance()
	inst.set_pos(get_pos())
	inst.set_emitting(true)
	Walls.add_child(inst)