extends FaciUnk

func _data():
	._data()
	tab = "world dungeon"

func _trig():
	lv = 5
	var g = per(150)
	sys.eventDlg.txt(tr("消耗 %d 金币 换取 %d点魂") % [g,lvPer(lv,50)],true)
	var inx = yield(sys.eventDlg.sel([tr("确定"),tr("放弃")]),"onSel")
	if inx == 0 :
		if sys.player.subItem("m_gold",g) :
			sys.player.items.addItem(data.newBase("m_xp").setNum(lvPer(lv,50)))
			del()
		else:
			sys.newMsg("金币 不足")
