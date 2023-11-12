extends "res://tscn/eventDlg/eventBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var box = $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var isNext = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(arr,isNext = false):
	self.isNext = isNext
	for i in arr.size() :
		var bt = Button.new()
		bt.text = arr[i]
		bt.rect_min_size.x = 60
		bt.connect("pressed",self,"r",[i,arr[i]])
		box.add_child(bt)
		
func initBB(arr,isNext = false):
	self.isNext = isNext
	for i in arr.size() :
		var bt = preload("res://tscn/eventDlg/selItemBB.tscn").instance()
		box.add_child(bt)
		bt.get_node("txt").bbcode_text = arr[i]
		bt.connect("pressed",self,"r",[i,arr[i]])
		rect_min_size.y += 25
func r(inx,s):
	var txt = Label.new()
	txt.text = s
	for i in box.get_children():
		i.queue_free()
	box.add_child(txt)
	if isNext == false: 
		emit_signal("onSel",inx)
	hide()
