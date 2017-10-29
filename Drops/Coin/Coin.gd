extends "res://References/NodeReference.gd"

onready var CoinArea = get_node("CoinArea")

var velocity = Vector2()
var remainder = Vector2()

var movespeed = 8
var max_speed = 1.5

func _ready():
	set_random_velocity()
	CoinArea.connect("body_enter", self, "collect")
	set_process(true)
	
func _process(delta):
	if (Math.distance_to_point(get_pos(), Player.get_pos()) < 48):
		move_to_player()
	else:
		stop_movement()
		
func set_random_velocity():
	velocity = Math.rand_rangev(-4, 4)
	
func collect(body):
	if (body == Player):
		queue_free()

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