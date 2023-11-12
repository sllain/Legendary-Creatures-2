extends FaciUnk

func _data():
	._data()
	tab = "world dungeon"

func _trig():
	lv = 4
	var g1 = per(150)
	sys.eventDlg.txt(tr("二选一"),true)
	var inx = yield(sys.eventDlg.selBB([tr("获得1个随机装备"),tr("获得2个随机宝石")]),"onSel")
	var itemPck = ItemPck.new()
	if inx == 0 :
		itemPck.addItem(getRndEqp(lv,lv))
	elif inx == 1 :
		for i in 2 :
			var item:Gem = data.newBase(rnp.gemPool.rndItem().id)
			item.createRndLv(lv,lv)
			itemPck.addItem(item)
	sys.eventDlg.items(itemPck)
	del()

