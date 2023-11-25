extends "res://tscn/eventDlg/eventBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var reUpBtn = $reUpBtn
onready var box = $ScrollContainer/HBoxContainer
var items = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(skills):
	for i in box.get_children():
		i.queue_free()
	for i in skills.items:
		var bt = load("res://tscn/eventDlg/eventSkill/itemSkillSel.tscn").instance()
		box.add_child(bt)
		bt.init(i)
		bt.connect("onSel",self,"r")
	focusBox = box
	
func r(skill):
	for i in box.get_children():
		i.queue_free()
	emit_signal("onSel",skill)

func _on_Button_pressed():
	emit_signal("onSel",null)


