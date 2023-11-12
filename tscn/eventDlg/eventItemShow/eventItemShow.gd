extends "res://tscn/eventDlg/eventBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var lab = $lab

var items : ItemPck
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(items):
	$items.init(items.items)
	self.items = items

func _on_Button_pressed():
	$Button.hide()
	emit_signal("onSel",null)
	pass # Replace with function body.
