extends "NodeReference.gd"

onready var fireball = load("res://Scenes/PlayerFireball.tscn")

func _ready():
	PlayerSprites.connect("finished", self, "animation_end")
	
func animation_end():
	if (Inputs.mouse_left):
		fireball_attack()
	
func fireball_attack():
	var inst = fireball.instance()
	inst.set_pos(Player.get_pos())
	Walls.add_child(inst)
