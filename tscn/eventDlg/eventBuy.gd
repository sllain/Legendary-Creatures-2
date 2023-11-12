extends "res://tscn/eventDlg/eventBase.gd"
var items:ItemPck

onready var reUpBtn = $reUpBtn

signal onBuy(item)
func init(items):
	for i in $items/box.get_children():
		i.queue_free()
	for i in items.items:
		var bt = preload("res://tscn/eventDlg/itemBuy.tscn").instance()
		$items/box.add_child(bt)
		bt.init(i)
		bt.connect("onBuy",self,"r")
	self.items = items
func _on_Button_pressed():
	emit_signal("onSel",null)

func r(item):
	items.delItem(item)
	emit_signal("onBuy",item)
