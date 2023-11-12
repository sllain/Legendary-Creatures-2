extends Relic

var maps = []

func _data():
	name = "遗迹探索者"
	lock = 0
	excMode = "tower"
	
func getDec():
	return tr("发现一个地牢时%d%%的几率减少1层瘴气") % [lvPer(lv,30)]

func _in():
	sys.game.connect("onFaciFound",self,"r")

func r(faci):
	if faci.id == "faci_dungeon":
		maps.append(id)
		if sys.rndPer(lvPer(lv,0.3)):
			sys.eventDlg.txt(tr("发现新的遗迹，减少1层瘴气！"))
			if sys.game.globals.g_m.lv >= 1:
				sys.game.globals.g_m.lv -= 1

