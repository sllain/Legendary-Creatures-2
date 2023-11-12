extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RichTextLabel_meta_clicked(meta):
	if meta == "u1":
		OS.shell_open("https://store.steampowered.com/app/1191840/Legend_Creatures/")
	elif meta == "u2":
		OS.shell_open("https://store.steampowered.com/app/610960/__Red_Obsidian_Remnant/")
	elif meta == "u3":
		OS.shell_open("https://weibo.com/ROStudio")
	pass # Replace with function body.
