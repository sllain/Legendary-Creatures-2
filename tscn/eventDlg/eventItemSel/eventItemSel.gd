extends "res://tscn/eventDlg/eventBase.gd"


signal onOk()

var items :ItemGrid
var type = 0
var isOnly = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(num,type = 0,isOnly = true):
	items = ItemGrid.new(num)
	self.isOnly = isOnly
	self.type = type
	for i in num :
		var bt = preload("res://tscn/eventDlg/eventItemSel/itemSel.tscn").instance()
		$ScrollContainer/HBoxContainer.add_child(bt)
		bt.init(null)
		bt.connect("onSel",self,"r",[bt,i])
		
func r(bt,inx):
	if bt.item != null:
		bt.item = null
		items.delInxItem(inx)
	var dlg = sys.newDlg("res://tscn/item/selItemDlg.tscn")
	dlg.init(sys.player.items,type,items,isOnly)
	var item = yield(dlg,"onSel")
	bt.init(item)
	items.addItem(item,inx)

func _on_Button_pressed():
	for i in items.items:
		if i == null:
			sys.newMsg("缺少物品")
			return
	emit_signal("onSel",items)
	hide()

func _on_Button2_pressed():
	emit_signal("onSel",null)
	hide()
