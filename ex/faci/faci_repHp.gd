extends FaciBat

func _data():
	name = "圣坛"
	dec = "恢复满全队生命值，及领取其他奖励"
	weight = 0.5
	num = 5
	tab = "world"
	isCs = true
	
func _in():
	lv = 0
	
func _trig():
	sys.eventDlg.txt("%s" % [dec],true)
	var ls = [
			tr("激活：恢复满全队生命值"),
			tr("离开")
		]
	var cry = lvPer(lv,10)
	var inx = yield(sys.eventDlg.selBB(ls),"onSel")
	if inx == 0 :
		for i in sys.player.team.chas :
			i.revive()
			i.plusHp(i.maxHp)
		sys.eventDlg.txt(tr("已回复生命值"))
		del()
		if sys.game.mode == "tower" :
			relicDlg()
			return
		var ls2 = [
			tr("减少 2级瘴气"),
			tr("获得 神徽")
		]
		var inx2 = yield(sys.eventDlg.selBB(ls2),"onSel")
		if inx2 == 0 :
			sys.game.globals.g_m.lv -= 2
		else:
			relicDlg()
		
	else:
		pass
	
	
