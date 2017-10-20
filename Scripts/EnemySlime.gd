extends "Enemy.gd"

onready var SlimeState = get_node("SlimeState")

var agro_range = 200

func _ready():
	set_process(true)
	
func _process(delta):
	if (Math.distance_to_point(get_pos(), Player.get_pos()) < agro_range):
		SlimeState.set_current_state("attack")
	
func damage():
	pass
	
func destroy():
	pass