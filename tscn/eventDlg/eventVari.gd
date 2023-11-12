extends "res://tscn/eventDlg/eventBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var box = $ScrollContainer/HBoxContainer
var items = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var cha :Chara
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(cha):
	self.cha = cha
	for i in 2 :
		items.append(data.newBase(rnp.variPool.rndItem(self,"rnf").id))
	for i in items:
		var bt = preload("res://tscn/eventDlg/itemVariSel.tscn").instance()
		box.add_child(bt)
		bt.init(i)
		bt.connect("onSel",self,"r")
	if box.get_child_count() <= 0 :
		$Button.hide()
	
func r(skill):
	for i in box.get_children():
		i.queue_free()
	emit_signal("onSel",skill)

func _on_Button_pressed():
	emit_signal("onSel",null)

func rnf(vari):
	for i in cha.skills.items:
		if i.id == vari.id :
			return false
	for i in items:
		if i.id == vari.id :
			return false
	return true
