extends FaciUnk

func _data():
	._data()
	tab = "world dungeon"

func _trig():
	var g1 = 900
	var g2 = 300
	sys.eventDlg.txt(tr("你愿意花费什么，获得一个遗物？"),true)
	var inx = yield(sys.eventDlg.selBB([tr("%d 金币") % g1,tr("%d 魂") % g2,tr("放弃")]),"onSel")
	if inx == 0 :
		if sys.player.subItem("m_gold",g1) :
			r()
		else:
			sys.eventDlg.txt(tr("金币 不足"))
	if inx == 1 :
		if sys.player.subItem("m_xp",g2) :
			r()
		else:
			sys.eventDlg.txt(tr("魂值 不足"))

func r():
	relicDlg()
	del()
