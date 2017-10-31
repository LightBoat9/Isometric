extends Node
	
onready var UseItem = get_node("UseItem")
onready var EquiptItem = get_node("EquiptItem")
	
var Slot = load("res://Inventory/Slot/InvetorySlot.tscn")
	
var slot_array = []
var slot_size = 28
var slot_space = 4
	
var selected_slot = null setget set_selected_slot, get_selected_slot
	
var item_num = 0
var max_item_num = 25

func _ready():
	UseItem.connect("button_down", self, "use_item")
	EquiptItem.connect("button_down", self, "equipt_item")
	var inventory_start = Vector2(268+48-8, 64)
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
		
func set_selected_slot(value):
	# Deselect last slot if its not null
	if (selected_slot != null): selected_slot.selected = false
	# Select new slot
	selected_slot = value
	if (selected_slot != null):
		selected_slot.selected = true
	update_buttons()
	
func update_buttons():
	UseItem.set_disabled(selected_slot == null)
	EquiptItem.set_disabled(selected_slot == null)
	
func use_item():
	if (selected_slot != null):
		selected_slot.use_item()
		item_num -= 1
	update_slot_array()
	
func update_slot_array():
	var select_num = slot_array.find(selected_slot)
	
	if (select_num == slot_array.size() - 1):
		set_selected_slot(null)
	else:
		if (slot_array[select_num + 1].item_index == -1):
			set_selected_slot(null)
	
	for i in range(select_num, slot_array.size() - 1):
		slot_array[i].set_item_index(slot_array[i + 1].get_item_index())
		slot_array[i + 1].set_item_index(-1)
		
	
	
func equipt_item():
	if (selected_slot != null):
		selected_slot.equipt_item()
	
func get_selected_slot():
	return selected_slot
	