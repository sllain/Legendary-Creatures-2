extends FaciUnk

func _data():
	._data()
	tab = "world dungeon"

var g = 50

func _trig():
	lv = 4
	g = lvPer(lv,100,0.5)
	sys.eventDlg.txt(tr("花%d 魂 赌一把？") % [g],true)
	var inx = yield(sys.eventDlg.selBB([tr("%d%% 获得 %d魂") % [100,g],tr("%d%% 获得 %d魂") % [60,g * 2],tr("%d%% 获得 %d魂") % [40,g * 3]]),"onSel")
	if inx != 3 :
		du(inx)
	
			
func du(b):
	if sys.player.subItem("m_xp",g) :
		if rndPer([1.0,0.6,0.4][b]) :
			sys.player.items.addItem(data.newBase("m_xp").setNum(g * (b + 2)))
			sys.eventDlg.txt(tr("获得%d魂") % [g * (b + 1)])
		else:
			sys.eventDlg.txt(tr("失败"))
		del()
	else:
		sys.eventDlg.txt(tr("魂值 不足"))
