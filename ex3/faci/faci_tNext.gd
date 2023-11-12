extends Faci

func _data():
	name = "传送门"
	dec = "前往下一层"
	weight = 0.5
	tab = "world"
	isCs = true
	num = 5
	icoId = "ico_faci_dengTa"
	excMode = "map"
	lock = -1

func _in():
	lv = 0
	
func _trig():
	var ls = [
			tr("前往下一层"),
			tr("离开")
		]
	var cry = lvPer(lv,10)
	var inx = yield(sys.eventDlg.selBB(ls),"onSel")
	if inx == 0 :
		del()
		sys.game.globals.g_tMap.next()


