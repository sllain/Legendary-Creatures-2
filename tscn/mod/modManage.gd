extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var dt = Directory.new()
	var dir = OS.get_executable_path().get_base_dir() + "/mods"
	dt.make_dir_recursive(dir)
	sys.main.searchPck(dir)

func _on_Button_pressed():
	queue_free()
	sys.main.modStart()
	pass # Replace with function body.
