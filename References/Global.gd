extends "NodeReference.gd"

var current_scene

func _ready():
	set_pause_mode(PAUSE_MODE_PROCESS)
	var Root = get_tree().get_root()
	current_scene = Root.get_child(Root.get_child_count() -1)
	set_process_input(true)
	load_game()
	
func _room_change():
	load_game()

func _input(event):
	# Toggle fullscreen
	if (event.type == InputEvent.KEY && event.pressed && event.scancode == KEY_F):
		OS.set_window_fullscreen(!OS.is_window_fullscreen())
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	var current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	_room_change()
	
func save_game():
	# Save Dictionary
	var data = {
		# Player
	}
	
	var file = File.new()
	if file.open("user://saved_game.sav", File.WRITE) != 0:
	    print("Error opening file")
	    return
	
	file.store_line(data.to_json())
	file.close()
	
func load_game():
	# Find saved file
	var file = File.new()
	if !file.file_exists("user://saved_game.sav"):
	    print("No file saved!")
	    return
	
	# Open file
	if file.open("user://saved_game.sav", File.READ) != 0:
	    print("Error opening file")
	    return
	
	# Get the data
	var data = {}
	data.parse_json(file.get_line())
	
	if (data != null):
		for i in get_tree().get_nodes_in_group("load"):
			i.load_game(data)
			
func get_level():
	return Game.get_name().substr(5,Game.get_name().length())