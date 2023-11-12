extends Relic

func _data():
	name = "夜行"
	lock = 0
	excMode = "tower"
	
func getDec():
	return tr("夜晚战斗时，全队 +%d%%增伤") % [lvPer(lv,20)]

func _in():
	sys.game.connect("onChaCastHurtStart",self,"r")
	
func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team and sys.game.isNight():
		atkInfo.per += lvPer(lv,0.20)
