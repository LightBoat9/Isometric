extends "res://References/NodeReference.gd"

onready var DropArea = get_node("DropArea")
onready var ItemSprite = get_node("ItemSprite")

var velocity = Vector2()
var remainder = Vector2()

var movespeed = 8
var max_speed = 1.5

var slot_size = Vector2(24, 24)
export var item_index = -1 setget set_item_index, get_item_index

func _ready():
	DropArea.connect("body_enter", self, "collect")
	set_process(true)
	
func _process(delta):
	if (Math.distance_to_point(get_pos(), Player.get_pos()) < 48):
		move_to_player()
	else:
		stop_movement()
	
func collect(body):
	if (body == Player):
		queue_free()
		PlayerInventory.add_item(item_index)

func move_to_player():
	var player_dir = (Math.point_directionv(
		get_pos(), Player.get_pos()).normalized())
		
	velocity.x = lerp(velocity.x, max_speed * player_dir.x, 
		movespeed * get_process_delta_time())
	velocity.y = lerp(velocity.y, max_speed * player_dir.y, 
		movespeed * get_process_delta_time())
	
	remainder = move(velocity)
	if (is_colliding()):
		_slide_on_walls()
		
func stop_movement():
	velocity.x = lerp(velocity.x, 0, movespeed * get_process_delta_time())
	velocity.y = lerp(velocity.y, 0, movespeed * get_process_delta_time())
		
	remainder = move(velocity)
	if (is_colliding()):
		_slide_on_walls()
	
func _slide_on_walls():
	var n = get_collision_normal()
	remainder = n.slide(remainder)
	move(remainder)
	
func set_item_index(value):
	item_index = value
	update_item()

func get_item_index():
	return item_index

func update_item():
	if (ItemSprite == null): return
	if (item_index == -1):
		ItemSprite.hide()
	else:
		ItemSprite.show()
		ItemSprite.set_region_rect(
			Rect2(Vector2((item_index % 10) * 28, (item_index / 10) * 28), 
				slot_size))