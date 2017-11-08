# Holds references to important nodes
extends Node

# Root and base node
onready var Root = get_tree().get_root()
onready var Game = Root.get_child(Root.get_child_count() - 1)
onready var Inputs = Root.get_node("Inputs")
onready var Math = Root.get_node("Math")
onready var Global = Root.get_node("Global")

# Base node children
onready var Floor = Game.get_node("Floor")
onready var Walls = Game.get_node("Walls")

# Wall children
onready var Player = Walls.get_node("Player")

# Player children
onready var PlayerSprites = Player.get_node("PlayerSprites")

# Player HUD children
onready var PlayerInventory = Player.get_node("HUD/PlayerInventory")
onready var PlayerHP = Player.get_node("HUD/PlayerHP")
onready var PlayerHUDSpells = Player.get_node("HUD/Spells")