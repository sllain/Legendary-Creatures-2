extends Relic

func _data():
	name = "永恒"
	lock = 0
	
func getDec():
	return tr("辅助单位升级时额外获得%d个技能点") % [lvPer(lv,1)]

func _in():
	sys.game.connect("onChaPlusLv",self,"r")

func r(cha):
	if cha.team == sys.player.team && cha.hasTab("辅助"):
		cha.sp += lvPer(lv,1)
