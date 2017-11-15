# The attack state of EnemySlime
extends "res://References/NodeReference.gd"

onready var EnemySlime = get_parent()

var velocity = Vector2()
var remainder = Vector2()
var movespeed = 10
var max_speed = 0.8

var damage = 1

func update():
	var player_dir = (Math.point_directionv(
		EnemySlime.get_pos(), Player.get_pos()).normalized())
	velocity.x = lerp(velocity.x, max_speed * player_dir.x, movespeed * get_process_delta_time())
	velocity.y = lerp(velocity.y, max_speed * player_dir.y, movespeed * get_process_delta_time())
	remainder = EnemySlime.move(velocity)
	if (EnemySlime.is_colliding()):
		_damage_player()
		_slide_on_walls()
		
func _damage_player():
	var c = EnemySlime.get_collider()
	if (c == null): return
	if (c == Player):
		# Pass in velocity to handle knockback
		PlayerHP.damage(damage, velocity.normalized()) 
		
func _slide_on_walls():
	var n = EnemySlime.get_collision_normal()
	remainder = n.slide(remainder)
	EnemySlime.move(remainder)