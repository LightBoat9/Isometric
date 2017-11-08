# Slime that attacks the player if they get close enough
extends "res://Enemies/Enemy.gd"

# Slime Nodes
onready var HPBar = get_node("HPBar")
onready var HPMid = get_node("HPBar/HPMid")
onready var ModTimer = get_node("ModTimer")
onready var SlimeAttack = get_node("SlimeAttack")
onready var SlimeSprites = get_node("SlimeSprites")
onready var SlimeState = get_node("SlimeState")

var DestroyParticles = load("res://Enemies/Slime/SlimeParticles.tscn")

var agro_range = 125

var hp = 1
var max_hp = 1
	
func _ready():
	ModTimer.connect("timeout", self, "reset_modulate")
	set_process(true)
	
func _process(delta):
	if (Math.distance_to_point(get_pos(), Player.get_pos()) < agro_range):
		SlimeState.set_current_state("attack")
	
func update_hp_bar():
	HPBar.show()
	HPMid.set_scale(Vector2(hp / max_hp,1))
	
func reset_modulate():
	SlimeSprites.set_modulate(Color(1, 1, 1))
	
func damage(amount, knockback_dir):
	SlimeSprites.set_modulate(Color(3, 3, 3))
	knock_back(knockback_dir, 2)
	ModTimer.start()
	hp -= amount
	if (hp <= 0): destroy()
	update_hp_bar()
	
func knock_back(dir, force):
	SlimeAttack.velocity = dir * force
	
func destroy():
	spawn_particles()
	drop_coin(5)
	queue_free()
	
func spawn_particles():
	var inst = DestroyParticles.instance()
	inst.set_emitting(true)
	inst.set_pos(get_pos())
	Walls.add_child(inst)