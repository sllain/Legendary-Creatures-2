extends Faci

var items = ItemPck.new()
var chas = ItemPck.new()

func _data():
	isCs = true
	isPressed = true
	name = "铁匠"
	dec = "合成装备，升级装备"
	weight = 0.5
	tab = "world"
	num = 5

var n1 = 3
var g = 100

func _in():
	lv = 0

func _trig():
	items.clear()
	sys.eventDlg.txt(dec,true)
	var inx = yield(sys.eventDlg.selBB([tr("合成装备 | 剩余%d次") % n1,tr("升级装备（需要宝石）"),tr("重新随机一个装备的词条"),tr("离开")]),"onSel")
	if inx == 0 :
		if n1 <= 0 :
			sys.eventDlg.txt(tr("次数 不足"))
			return
		var dlg = sys.eventDlg.itemSel(3,1,false)
		dlg.connect("onSel",self,"_r")
	elif inx == 1 :
#		if n1 <= 0 :
#			sys.eventDlg.txt("次数 不足")
#			return
		yield(sys.eventDlg.selBB([tr("选择一个装备")]),"onSel")
		var dlg = sys.newDlg("res://tscn/item/selItemDlg.tscn")
		dlg.init(sys.player.items,1,null,false)
		yield(dlg,"onDel")
		var eqp :Eqp = dlg.selItem
		if eqp == null: return
		yield(sys.eventDlg.selBB([tr("选择一颗比装备高一级的宝石")]),"onSel")
		dlg = sys.newDlg("res://tscn/item/selItemDlg.tscn")
		dlg.init(sys.player.items,4)
		yield(dlg,"onDel")
		if dlg.selItem == null :return
		var gem = dlg.selItem
		if gem.lv - eqp.lv != 1 :
			sys.eventDlg.txt(tr("宝石必须比装备高一级"))
			return
		var g2 = int(100 * pow(3,eqp.lv-1) * 0.5)
		var inx2 = yield(sys.eventDlg.selBB([tr("支付 %d 金币") % g2,tr("放弃")]),"onSel")
		if inx2 == 0 : 
			if sys.player.subItem("m_gold",g2) == false :
				sys.eventDlg.txt(tr("金币 不足"))
				return
		else:
			return
		sys.player.items.delItem(gem)
		eqp.plusLv(gem)
		var itemPck = ItemPck.new()
		itemPck.addItem(eqp)
		sys.eventDlg.itemShow(itemPck)
	elif inx == 2 :
		var dlg = sys.newDlg("res://tscn/item/selItemDlg.tscn")
		dlg.init(sys.player.items,1,null,false)
		dlg.connect("onSel",self,"_r2")
		
func _r(items):
	if items == null :return
	if items.items[0].lv != items.items[1].lv || items.items[1].lv != items.items[2].lv :
		sys.eventDlg.txt(tr("装备等级不一致"))
		return
	var ii = items.items[0]
	for i in items.items:
		sys.player.items.delItem(i)
	items.clear()
	eqpSelDlg(ii.lv + 1)
	n1 -= 1	
	if n1 <= 0 :self.invalid = true
	
func _r2(aitem):
	if aitem == null :return
	var g3 = 100 * pow(3,aitem.lv-1) * 0.2
	var inx2 = yield(sys.eventDlg.selBB([tr("支付 %d 金币") % g3,tr("放弃")]),"onSel")
	if inx2 == 0 :
		if sys.player.subItem("m_gold",g3) == false: 
			sys.eventDlg.txt(tr("金币 不足"))
			return
	else:
		return
	var item = data.newBase(aitem.id)
	item.create(aitem.lv)
	sys.player.items.delItem(aitem)
	var itemPck = ItemPck.new()
	itemPck.addItem(item)
	sys.eventDlg.items(itemPck)

func getSave():
	var ds = {
		n1 = n1,
	}
	ds.merge(.getSave())
	return ds
	
func setSave(ds):
	.setSave(ds)
	dsSet("n1",ds)
