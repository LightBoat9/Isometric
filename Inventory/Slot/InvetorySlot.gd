extends "res://Inventory/Items/Item.gd" 

onready var Information = get_node("Information")
onready var ItemSprite = get_node("ItemSprite")
onready var SlotShadow = get_node("SlotShadow")
onready var SlotSprite = get_node("SlotSprite")

# Information Nodes
onready var Name = Information.get_node("Name")
onready var Description = Information.get_node("Description")
onready var Type = Information.get_node("Type")

var slot_size = Vector2(28, 28)

var mouse_hover = false

func _ready():
	set_item_index(-1)
	set_process(true)
	set_process_input(true)
	
func _input(event):
	if (item_index == -1): return
	# Item Select
	if (event.is_action_pressed("mouse_left")):
		if (mouse_hover):
			use_item()
	# Mouse Hover
	if (event.type == InputEvent.MOUSE_MOTION):
		if (event.pos.x - get_global_pos().x < 28 && event.pos.x - get_global_pos().x > 0 &&
			event.pos.y - get_global_pos().y < 28 && event.pos.y - get_global_pos().y > 0):
			mouse_hover = true
			SlotShadow.hide()
			Information.show()
		else:
			mouse_hover = false
			SlotShadow.show()
			Information.hide()
	
func _process(delta):
	if (item_index == -1): return
	if (mouse_hover):
		Information.set_global_pos(Math.addv(Information.get_global_mouse_pos(), 2))
		Name.set_text(items_dict[Vector2(item_index, 0)])
		Type.set_text(items_dict[Vector2(item_index, 1)])
		Description.set_text((items_dict[Vector2(item_index, 2)]))
	
func update_item():
	if (item_index == -1):
		ItemSprite.hide()
		SlotShadow.show()
		Information.hide()
	else:
		ItemSprite.show()
		ItemSprite.set_region_rect(
			Rect2(Vector2((item_index % 10) * 28, (item_index / 10) * 28), 
				slot_size))
	
func use_item():
	if (items_dict[Vector2(item_index, 1)] == "Key Item"):
		call_deferred("use_key_item", items_dict[Vector2(item_index, 0)])
	
	set_item_index(-1)
	
func use_key_item(name):
	if (name == "Fireball Scroll"):
		PlayerSpells.m1_active = true