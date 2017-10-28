extends "NodeReference.gd"

onready var CoinArea = get_node("CoinArea")

func _ready():
	CoinArea.connect("body_enter", self, "collect")
	
func collect(body):
	if (body == Player):
		queue_free()
