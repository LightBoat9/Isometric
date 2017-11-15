extends "res://References/NodeReference.gd"
	
onready var UseItem = get_node("UseItem")
onready var EquiptItem = get_node("EquiptItem")
	
var Slot = load("res://Inventory/Slot/InvetorySlot.tscn")
	
var slot_array = []
var slot_size = 28
var slot_space = 4
	
var selected_slot = null setget set_selected_slot, get_selected_slot

var equip_array = []
	
var item_num = 0
var row_amount = 4
var col_amount = 5
var max_item_num = row_amount * col_amount

var initial_pos = Vector2(238, 58)

func _ready():
	set_pos(initial_pos)
	UseItem.connect("button_down", self, "use_item")
	EquiptItem.connect("button_down", self, "equipt_item")
	instance_inventory()
	instance_equipment()
	set_process_input(true)
	
func _input(event):
	if (get_tree().is_paused()): return
	if (event.is_action_pressed("key_inventory")):
		toggle_open()
		
func instance_inventory():
	var inventory_start = Vector2(108, 32)
	for y in range(row_amount):
		for x in range(col_amount):
			var inst = Slot.instance()
			var offset = slot_size + slot_space
			inst.set_pos(Vector2(inventory_start.x + offset * x,
				inventory_start.y + offset * y))
			add_child(inst)
			slot_array.append(inst)
			
func instance_equipment():
	var equip_start = Vector2(24, 48)
	for y in range(2):
		for x in range(2):
			var inst = Slot.instance()
			var offset = slot_size + slot_space
			inst.set_pos(Vector2(equip_start.x + offset * x,
				equip_start.y + offset * y))
			add_child(inst)
			equip_array.append(inst)
			
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
	
func toggle_open():
	if (Player.StateMachine.current_state != "inventory"):
		Player.StateMachine.current_state = "inventory"
		show()
	else:
		Player.StateMachine.current_state = Player.StateMachine.last_state
		hide()
	