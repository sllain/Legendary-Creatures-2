extends Faci

func _data():
	name = "木箱"
	dec = ""
	weight = 1
	num = 10
	tab = "world dungeon"
	dnum = 2

func _trig():
	var itemPck = ItemPck.new()
	var i1 = data.newBase("m_gold")
	i1.num = lvPer(1,100)
	itemPck.addItem(i1)
	
	var item = data.newBase(rnp.eqpPool.rndItem().id)
	item.createRndLv(lv)
	itemPck.addItem(item)
	
	item = data.newBase(rnp.csbPool.rndItem().id)
	item.lv = lv
	itemPck.addItem(item)
	trigInfo("boxOpen",itemPck)
	sys.eventDlg.items(itemPck)
	del()
	
