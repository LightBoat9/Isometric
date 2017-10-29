extends Node

var Slot = load("res://Inventory/Slot/InvetorySlot.tscn")

var slot_array = []
var slot_size = 28
var slot_space = 4

func _ready():
	for i1 in range(5):
		for i2 in range(5):
			var inst = Slot.instance()
			var offset = slot_size + slot_space
			inst.set_pos(Vector2(offset * i1, offset * i2))
			add_child(inst)
			slot_array.append(inst)
			
	slot_array[0].set_item_index(0)