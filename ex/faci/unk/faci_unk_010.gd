extends FaciUnk

func _data():
	._data()
	tab = "world dungeon"
	weight = 0.2

func _trig():
	var g1 = per(150)
	sys.eventDlg.txt(tr("二选一"),true)
	var inx = yield(sys.eventDlg.selBB([tr("减少1点瘴气"),tr("时间推进 %s，获得1个遗物") % sys.getTimeStr(6)]),"onSel")
	if inx == 0 :
		sys.game.globals.g_m.lv -= 1
	elif inx == 1 :
		sys.game.nextTime(6)
		relicDlg()
	del()

