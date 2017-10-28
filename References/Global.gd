extends Node

var current_scene

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	set_process_input(true)

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