extends "res://References/NodeReference.gd"

func _ready():
	set_process(true)
	
func _process(delta):
	# Flip sprite based on direction
	PlayerSprites.set_flip_h(Player.Movement.get_direction().x == -1)
