extends "res://References/NodeReference.gd"

var max_hp = 10
var hp = 10

var heart_array = []
var back_array = []

var Heart = load("res://Player/HUD/Textures/Heart/0.png")
var HurtHeart = load("res://Player/HUD/Textures/HurtHeart/0.png")

var invin = false
var invin_timer
var invin_amount = 2.0
var blink_timer
var blink_rate = 0.1

func _ready():
	instance_hearts()
	create_invin_timer()
	create_blink_timer()
	update()
	
func instance_hearts():
	for i in range(10):
		var inst = Sprite.new()
		inst.set_centered(false)
		heart_array.append(inst)
		inst.set_pos(Vector2(8 + (18 * i), 8))
		inst.set_texture(Heart)
		add_child(inst)
	
func create_invin_timer():
	invin_timer = Timer.new()
	invin_timer.set_wait_time(invin_amount)
	invin_timer.set_one_shot(true)
	invin_timer.connect("timeout", self, "invin_end")
	add_child(invin_timer)
	
func invin_end():
	invin = false
	blink_timer.stop()
	PlayerSprites.show()
	
func create_blink_timer():
	blink_timer = Timer.new()
	blink_timer.set_wait_time(blink_rate)
	blink_timer.connect("timeout", self, "blink")
	add_child(blink_timer)
	
func blink():
	if (PlayerSprites.is_visible()): PlayerSprites.hide()
	else: PlayerSprites.show()
	
func update():
	for i in heart_array:
		i.set_texture(Heart)
	for i in range(hp):
		heart_array[i].show()
	for i in range(10 - hp):
		heart_array[9 - i].set_texture(HurtHeart)
	
func damage(amount, knockback_dir):
	if (invin): return
	invin = true
	invin_timer.start()
	blink_timer.start()
	PlayerMovement.knock_back(knockback_dir, 4)
	if (hp - amount >= 0): hp -= amount
	else: hp = 0
	update()
	
func heal(amount):
	if (hp + amount < max_hp): hp += amount
	else: hp = max_hp
	update()