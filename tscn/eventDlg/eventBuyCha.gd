extends "res://tscn/eventDlg/eventBase.gd"
var items

onready var reUpBtn = $reUpBtn

signal onRep()
func init(items):
	for i in $items/box.get_children():
		i.queue_free()
	for i in items.items:
		var bt = load("res://tscn/eventDlg/itemBuyCha.tscn").instance()
		$items/box.add_child(bt)
		bt.init(i)
		bt.connect("onBuy",self,"r")
	self.items = items
func _on_Button_pressed():
	emit_signal("onSel",null)
	hide()

func r(item):
	self.items.delItem(item)

func _on_Button2_pressed():
	emit_signal("onRep")

