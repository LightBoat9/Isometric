extends "StateMachine.gd"

onready var EnemySlime = get_parent()

var velocity = Vector2()
var movespeed = 40

var damage = 1

func _ready():
	set_current_state("idle")
	
func idle_enter(): pass
func idle_exit(): pass
func idle_update():
	pass

func attack_enter(): pass
func attack_exit(): pass
func attack_update(): 
	velocity = (Math.point_directionv(
		EnemySlime.get_pos(), Player.get_pos()).normalized())
	velocity = velocity * movespeed * get_process_delta_time()
	velocity = EnemySlime.move(velocity)
	if (EnemySlime.is_colliding()):
		var c = EnemySlime.get_collider()
		if (c == null): return
		if (c == Player):
			PlayerHP.damage(damage)
			
		var n = EnemySlime.get_collision_normal()
		velocity = n.slide(velocity)
		EnemySlime.move(velocity)
		