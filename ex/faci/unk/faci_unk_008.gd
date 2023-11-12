extends FaciUnk

func _data():
	._data()
	tab = "world dungeon"

func _trig():
	lv = 4
	var g1 = per(300)
	var g2 = per(50)
	sys.eventDlg.txt(tr("二选一"),true)
	var inx = yield(sys.eventDlg.selBB([tr("获得 %d 金币") % g1,tr("获得 %d 金币，但损失 %d 的魂") % [g1*2,g2]]),"onSel")
	var itemPck = ItemPck.new()
	if inx == 0 :
		itemPck.addItem(data.newBase("m_gold").setNum(g1))
	elif inx == 1 :
		if sys.player.subItem("m_xp",g2) :
			itemPck.addItem(data.newBase("m_gold").setNum(g1 * 2))
		else:
			sys.eventDlg.txt("魂值 不足")
	if itemPck.items.size() > 0 :
		sys.eventDlg.items(itemPck)
		del()
