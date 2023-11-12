extends Faci

func _data():
	._data()
	tab = "world"
	num = 3
	name = "提升宝石"
	dec = "将一颗宝石的等级提高1级,最多提升至4级"
	lock = 0
	lockType = 1
	achDec = "通关难度5"

func _trig():
	sys.eventDlg.txt(dec,true)
	var inx = yield(sys.eventDlg.selBB([tr("选择一颗宝石"),tr("放弃")]),"onSel")
	if inx == 0 :
		var dlg :BaseDlg= sys.newDlg("res://tscn/item/selItemDlg.tscn")
		dlg.init(sys.player.items,4)
		dlg.connect("onSel",self,"_r")

func _r(item):
	if item == null: return
	if item.lv < 4 :
		item.lv += 1
		sys.newMsg(tr("成功提升！"))
		del()
	else:
		sys.newMsg(tr("无法提升，必须是小于4级的宝石"))


func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 5 :
		achCom()
