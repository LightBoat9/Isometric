extends "res://References/NodeReference.gd"

onready var FireballArea = get_node("FireballArea")
onready var FireballSprite = get_node("FireballSprite")

var explode_particles = load("res://Player/Spells/ExplodeParticles.tscn")

var velocity = Vector2()
var speed = 200

var damage = 0.5

var lifetime = 0.5
var life_timer

func _ready():
	_create_life_timer()
	FireballArea.connect("body_enter", self, "collision")
	_start_velocity()
	set_process(true)
	
func _create_life_timer():
	life_timer = Timer.new()
	life_timer.set_wait_time(lifetime)
	life_timer.start()
	life_timer.connect("timeout", self, "destroy")
	add_child(life_timer)
	
func _start_velocity():
	velocity = Math.point_directionv(
		Math.addv(get_pos(), 15), 
		FireballSprite.get_global_mouse_pos()).normalized()
	velocity = velocity * speed * get_fixed_process_delta_time()
	
func _process(delta):
	move(velocity)
	
func collision(body):
	if (body.is_in_group("Wall")):
		destroy()
	elif (body.is_in_group("Enemies")):
		body.damage(damage, velocity.normalized())
		destroy()
	
func destroy():
	add_explode_particles()
	queue_free()

func add_explode_particles():
	var inst = explode_particles.instance()
	inst.set_pos(get_pos())
	get_parent().add_child(inst)
