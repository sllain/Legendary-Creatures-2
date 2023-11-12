extends FaciUnk

func _data():
	._data()
	tab = "world dungeon"

func _trig():
	lv = 4
	var g1 = per(50)
	var g2 = per(2)
	sys.eventDlg.txt(tr("二选一"),true)
	var inx = yield(sys.eventDlg.selBB([tr("获得 %d 魂") % g1,tr("获得 %d 魂，但损失 %d 的晶石") % [g1*2,g2]]),"onSel")
	var itemPck = ItemPck.new()
	if inx == 0 :
		itemPck.addItem(data.newBase("m_xp").setNum(g1))
		del()
	elif inx == 1 :
		if sys.player.subItem("m_cry",g2) :
			itemPck.addItem(data.newBase("m_xp").setNum(g1 * 2))
			del()
		else:
			sys.eventDlg.txt("晶石 不足")
	if itemPck.items.size() > 0 :
		sys.eventDlg.items(itemPck)
		
