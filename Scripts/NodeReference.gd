# Holds references to important nodes
extends Node

# Root and base node
onready var Root = get_tree().get_root()
onready var Game = Root.get_child(0)

# Base node children
onready var Floor = Game.get_node("Floor")
onready var Inputs = Game.get_node("Inputs")
onready var Math = Game.get_node("Math")
onready var Walls = Game.get_node("Walls")

# Wall children
onready var Player = Walls.get_node("Player")

# Player children
onready var PlayerGraphics = Player.get_node("PlayerGraphics")
onready var PlayerMovement = Player.get_node("PlayerMovement")
onready var PlayerSprites = Player.get_node("PlayerSprites")