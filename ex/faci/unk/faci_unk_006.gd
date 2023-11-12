extends FaciUnk

func _data():
	._data()
	tab = "dungeon"

func _trig():
	lv = 4
	sys.eventDlg.txt(tr("全队损失20%生命值，获得1个传奇装备"),true)
	var inx = yield(sys.eventDlg.sel([tr("确定"),tr("放弃")]),"onSel")
	if inx == 0 :
		for i in sys.player.team.chas :
			if i.cell.x < 5 :
				i.hp -= i.maxHp * 0.2
		var itemPck = ItemPck.new()
		for i in 1 :
			itemPck.addItem(getRndEqp(lv,lv))
		sys.eventDlg.items(itemPck)
		del()
