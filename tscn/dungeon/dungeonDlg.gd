extends BaseDlg


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var mapScene :MapScene = $mapScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	mapScene.init()
