extends Faci

func _data():
	._data()
	tab = "world"
	name = "交换"
	num = 5
	lock = 0
	lockType = 1
	dec = "将一个装备随机替换成另一个同等级装备"
	achDec = "通关难度9"

func _trig():
	sys.eventDlg.txt(dec,true)
	var inx = yield(sys.eventDlg.selBB([tr("选择一个装备"),tr("放弃")]),"onSel")
	if inx == 0 :
		var dlg :BaseDlg= sys.newDlg("res://tscn/item/selItemDlg.tscn")
		dlg.init(sys.player.items,1,null,false)
		dlg.connect("onSel",self,"_r")

func _r(aitem):
	if aitem == null :return
	var item = data.newBase(rnp.eqpPool.rndItem().id)
	item.create(aitem.lv)
	sys.player.items.delItem(aitem)
	var itemPck = ItemPck.new()
	itemPck.addItem(item)
	sys.eventDlg.items(itemPck)
	del()

func _ach():
	sys.game.connect("onEnd",self,"_onEnd")
func _onEnd(isWin):
	if isWin && sys.game.diffLv >= 9 :
		achCom()
