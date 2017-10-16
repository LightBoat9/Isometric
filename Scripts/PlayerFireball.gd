extends "NodeReference.gd"

onready var FireballArea = get_node("FireballArea")
onready var FireballSprite = get_node("FireballSprite")

var explode_particles = load("res://Scenes/ExplodeParticles.tscn")

var velocity = Vector2()
var speed = 200

func _ready():
	FireballArea.connect("body_enter", self, "collision")
	_start_velocity()
	set_process(true)
	
func _start_velocity():
	velocity = Math.point_directionv(
		Math.addv(get_pos(), 15), 
		FireballSprite.get_global_mouse_pos()).normalized()
	velocity = velocity * speed * get_process_delta_time()
	
func _process(delta):
	move(velocity)
	
func collision(body):
	if (body.is_in_group("Wall")):
		destroy()
	
func destroy():
	add_explode_particles()
	queue_free()

func add_explode_particles():
	var inst = explode_particles.instance()
	inst.set_pos(get_pos())
	get_parent().add_child(inst)
