extends FaciUnk

func _data():
	._data()
	tab = "world dungeon"

func _trig():
	lv = 4
	var g1 = per(150)
	sys.eventDlg.txt(tr("二选一"),true)
	var inx = yield(sys.eventDlg.selBB([tr("获得 %d 金币") % g1,tr("获得1件随机传奇装备")]),"onSel")
	var itemPck = ItemPck.new()
	if inx == 0 :
		itemPck.addItem(data.newBase("m_gold").setNum(g1))
	elif inx == 1 :
		itemPck.addItem(getRndEqp(lv,lv))
	sys.eventDlg.items(itemPck)
	del()

