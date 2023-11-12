extends "res://tscn/eventDlg/eventBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(items):
	$items.init(items.items)
	for i in items.items:
		sys.player.items.addItem(i)


func _pressed():
	if noPre():return
	$Button.hide()
	emit_signal("onSel",null)
	hide()
