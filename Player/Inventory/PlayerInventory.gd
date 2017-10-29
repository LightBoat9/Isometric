extends Node

var Slot = load("res://Inventory/Slot/InvetorySlot.tscn")

var slot_array = []
var slot_size = 28
var slot_space = 4

var item_num = 0
var max_item_num = 25

func _ready():
	var inventory_start = Vector2(268, 64)
	for y in range(5):
		for x in range(5):
			var inst = Slot.instance()
			var offset = slot_size + slot_space
			inst.set_pos(Vector2(inventory_start.x + offset * x,
				inventory_start.y + offset * y))
			add_child(inst)
			slot_array.append(inst)
			
func add_item(index):
	if (item_num < max_item_num):
		slot_array[item_num].set_item_index(index)
		item_num += 1