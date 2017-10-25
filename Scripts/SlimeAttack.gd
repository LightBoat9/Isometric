# The attack state of EnemySlime
extends "NodeReference.gd"

onready var EnemySlime = get_parent()

var velocity = Vector2()
var movespeed = 40

var damage = 1

func update():
	velocity = (Math.point_directionv(
		EnemySlime.get_pos(), Player.get_pos()).normalized())
	velocity = velocity * movespeed * get_process_delta_time()
	velocity = EnemySlime.move(velocity)
	if (EnemySlime.is_colliding()):
		_damage_player()
		_slide_on_walls()
		
func _damage_player():
	var c = EnemySlime.get_collider()
	if (c == null): return
	if (c == Player):
		PlayerHP.damage(damage)
		
func _slide_on_walls():
	var n = EnemySlime.get_collision_normal()
	velocity = n.slide(velocity)
	EnemySlime.move(velocity)