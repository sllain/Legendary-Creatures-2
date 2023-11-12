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
		var bt =  preload("res://tscn/bat/relic/bonusRelic.tscn").instance()
		$HBoxContainer.add_child(bt)
		for j in sys.player.relics.items:
			if i.id == j.id :
				i.lv = j.lv + 1
		bt.init(i)
		bt.connect("pressed",self,"r",[i])
	focusBox = $HBoxContainer
	pass
func r(item):
	emit_signal("onSel",item)
	for i in $HBoxContainer.get_children():
		i.queue_free()
	for i in sys.player.relics.items:
		if i.id == item.id :
			i.lv = item.lv
			return
	sys.player.relics.addItem(item)
	hide()
