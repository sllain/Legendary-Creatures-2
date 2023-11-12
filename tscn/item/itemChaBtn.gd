extends "res://tscn/item/itemBtn.gd"
class_name EqpChaBtn

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func init(item):
	.init(item)
	visible = item != null
	isDrag = true
	if item != null && item.wearer != null && item.wearer.team != sys.player.team :
		isDrag = false


func cdel():
	pass
