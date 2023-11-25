extends "res://tscn/item/itemDlg.gd"

signal onSel(item)
# Declare member variables here. Examples:
# var a = 2
var selItem = null
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
# 0:全部 1：装备 2：消耗品 3：材料 4：宝石 5：唯一装备
func init(items,type = 0,exItems = null,isOnly = true):
	self.type = type
	.init(items,type,exItems,isOnly)
	connect("onPressed",self,"rSel")

func addItem(item,inx):
	if isSel(item) == false: return
	var itemBtn = load("res://tscn/item/selItemBtn.tscn").instance()
	box.add_child(itemBtn)
	itemBtn.init(item)
	itemBtn.connect("pressed",self,"rPressed",[item])

func rSel(item):
	selItem = item
	del()

func del():
	.del()
	emit_signal("onSel",selItem)
	pass # Replace with function body.
