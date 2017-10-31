extends "res://Inventory/Items/Item.gd" 

onready var Information = get_node("Information")
onready var ItemSprite = get_node("ItemSprite")
onready var SlotShadow = get_node("SlotShadow")
onready var SlotSprite = get_node("SlotSprite")

# Information Nodes
onready var Name = Information.get_node("Name")
onready var Description = Information.get_node("Description")
onready var Type = Information.get_node("Type")

var tex_normal = load("res://Inventory/Slot/Textures/Slot/0.png")
var tex_highlight = load("res://Inventory/Slot/Textures/SlotSelected/0.png")
var slot_size = Vector2(28, 28)

var mouse_hover = false

var selected = false setget set_selected, get_selected

func _ready():
	set_item_index(-1)
	update_item()
	set_process(true)
	set_process_input(true)
	
func _input(event):
	if (item_index == -1): return
	# Item Select
	if (event.is_action_pressed("mouse_left")):
		if (mouse_hover):
			get_parent().set_selected_slot(self)
	# Mouse Hover
	if (event.type == InputEvent.MOUSE_MOTION):
		if (_is_mouse_over(event)):
			mouse_hover = true
		else:
			mouse_hover = false
		update_item()
	
func _process(delta):
	if (item_index == -1): return
	if (mouse_hover):
		Information.set_global_pos(Math.addv(Information.get_global_mouse_pos(), 2))
		Name.set_text(items_dict[Vector2(item_index, 0)])
		Type.set_text(items_dict[Vector2(item_index, 1)])
		Description.set_text((items_dict[Vector2(item_index, 2)]))
	
func use_item():
	if (items_dict[Vector2(item_index, 1)] == "Key Item"):
		call_deferred("use_key_item", items_dict[Vector2(item_index, 0)])
	elif (items_dict[Vector2(item_index, 1)] == "Potion"):
		call_deferred("use_potion", items_dict[Vector2(item_index, 0)])
	
	set_item_index(-1)
	
func equipt_item():
	pass
	
func use_key_item(name):
	if (name == "Fireball Scroll"):
		PlayerSpells.m1_active = true
		
func use_potion(name):
	if (name == "Health Potion"):
		PlayerHP.heal(3)
	
func update_item():
	if (mouse_hover && item_index != -1):
		SlotShadow.hide()
		Information.show()
	else:
		SlotShadow.show()
		Information.hide()
	_update_item_sprite()
	
func _update_item_sprite():
	ItemSprite.set_region_rect(
		Rect2(Vector2((item_index % 10) * 28, 
		(item_index / 10) * 28), slot_size)
		)
	
func set_selected(value):
	selected = value
	_update_highlight()

func get_selected():
	return selected
		
func _update_highlight():
	if (selected): SlotSprite.set_texture(tex_highlight)
	else: SlotSprite.set_texture(tex_normal)
	
# Return true if the mouse is over the slot area
func _is_mouse_over(event):
	return (
		event.pos.x - get_global_pos().x < 28 && 
		event.pos.x - get_global_pos().x > 0 &&
		event.pos.y - get_global_pos().y < 28 && 
		event.pos.y - get_global_pos().y > 0
		)