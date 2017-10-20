extends "StateMachine.gd"

onready var EnemySlime = get_parent()

var velocity = Vector2()
var movespeed = 40

func _ready():
	set_current_state("idle")
	
func idle_enter(): pass
func idle_exit(): pass
func idle_update():
	pass

func attack_enter(): print("TEST")
func attack_exit(): pass
func attack_update(): 
	velocity = (Math.point_directionv(
		EnemySlime.get_pos(), Player.get_pos()).normalized())
	velocity = velocity * movespeed * get_process_delta_time()
	velocity = EnemySlime.move(velocity)
	if (EnemySlime.is_colliding()):
		var n = EnemySlime.get_collision_normal()
		velocity = n.slide(velocity)
		EnemySlime.move(velocity)