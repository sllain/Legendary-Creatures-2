extends "res://tscn/item/itemBtn.gd"
signal onP(inx)

func _on_item_pressed():
	if item == null:return
	var dlg = sys.newDlg("res://tscn/item/itemInfoDlg.tscn")
	dlg.init(item,txt,true if item.masCha != null && item.masCha.team == sys.player.team else false)
	dlg.connect("onP",self,"rP")
	
func rP(inx):
	emit_signal("onP",inx)

func cdel():
	pass

func init(item,isTip = true):
	.init(item)
	if item == null && isTip: 
		sys.addTip(self,"点击穿戴装备")
