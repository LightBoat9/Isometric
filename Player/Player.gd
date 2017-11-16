extends "res://References/NodeReference.gd"

onready var HUD = get_node("HUD")
onready var M1Timer = get_node("M1Timer")

var StateMachine = load("res://Player/Scripts/PlayerStateMachine.gd").new()
var Graphics = load("res://Player/Scripts/PlayerGraphics.gd").new()
var Movement = load("res://Player/Scripts/PlayerMovement.gd").new()
var Spells = load("res://Player/Scripts/PlayerSpells.gd").new()

func _ready():
	add_child(StateMachine)
	add_child(Graphics)
	add_child(Movement)
	add_child(Spells)
	
func load_game(data):
	pass