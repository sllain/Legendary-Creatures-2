extends "res://tscn/item/itemBtn.gd"
class_name EqpLBtn

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(item):
	.init(item)
	item.connect("onSetWearer",self,"rWearer")
	rWearer()
	
func rWearer():
	isDrag = true
	if item.wearer == null:
		$wearer.hide()
	else:
		$wearer.show()
		sys.addTip($wearer,"%s,已穿戴" % item.wearer.name)
