extends "res://tscn/eventDlg/eventBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var reUpBtn = $reUpBtn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(items):
	for i in $HBoxContainer.get_children():
		i.queue_free()
	for i in items:
		var bt =  preload("res://tscn/eventDlg/eventItemSel/itemSel.tscn").instance()
		$HBoxContainer.add_child(bt)
		bt.init(i)
		bt.connect("onSel",self,"r",[i])
	focusBox = $HBoxContainer

func r(item):
	if noPre():return
	emit_signal("onSel",item)
	for i in $HBoxContainer.get_children():
		i.queue_free()
	sys.player.items.addItem(item)
	hide()

