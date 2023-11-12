extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var dt = Directory.new()
	dt.make_dir_recursive("user://mods/")
	sys.main.searchPck("user://mods/")


func _on_Button_pressed():
	queue_free()
	sys.main.modStart()
	pass # Replace with function body.
