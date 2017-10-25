# Slime that attacks the player if they get close enough
extends "Enemy.gd"

# Slime Nodes
onready var SlimeState = get_node("SlimeState")
onready var SlimeAttack = get_node("SlimeAttack")
onready var HPBar = get_node("HPBar")
onready var HPMid = get_node("HPBar/HPMid")

var DestroyParticles = load("res://Scenes/SlimeParticles.tscn")

var agro_range = 200

var hp = 1
var max_hp = 1
	
func _ready():
	set_process(true)
	
func _process(delta):
	if (Math.distance_to_point(get_pos(), Player.get_pos()) < agro_range):
		SlimeState.set_current_state("attack")
	
func update_hp_bar():
	HPBar.show()
	HPMid.set_scale(Vector2(hp / max_hp,1))
	
func damage(value):
	hp -= value
	if (hp <= 0): destroy()
	update_hp_bar()
	
func destroy():
	spawn_particles()
	drop_coin()
	queue_free()
	
func spawn_particles():
	var inst = DestroyParticles.instance()
	inst.set_emitting(true)
	inst.set_pos(get_pos())
	Walls.add_child(inst)