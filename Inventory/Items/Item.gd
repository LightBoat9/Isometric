extends "res://References/NodeReference.gd"

var item_index = 0 setget set_item_index, get_item_index

# All Items
# Vector2(index, 0) == item_name
# Vector2(index, 1) == item_type
# Vector2(index, 2) == item_description

# Key Items
# Vector2(index, 3) == method_name

# Potions
# Vector2(index, 3) == item_value

var items_dict = {
	##### Scrolls
	# Fireball Scroll (M1)
	Vector2(0,0): "Fireball Scroll",
	Vector2(0,1): "Key Item",
	Vector2(0,2): "Use to permanently learn the fireball spell",
	
	# Shield Scroll (Q)
	Vector2(1,0): "Shield Scroll",
	Vector2(1,1): "Key Item",
	Vector2(1,2): "Use to permanently learn the shield spell",
	
	##### Potions
	Vector2(6,0): "Health Potion",
	Vector2(6,1): "Potion",
	Vector2(6,2): "Restores three hearts",
	}
		
func set_item_index(index):
	item_index = index
	update_item()
	
func _update_item():
	pass # Updates the item/visuals
	
func get_item_index():
	return item_index
