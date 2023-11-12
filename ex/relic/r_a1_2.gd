extends Relic

func _data():
	name = "战斗之魂"
	
func getDec():
	return tr("战士获得%d%%的全能吸血") % [lvPer(lv,10)]
	
func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.castCha.hasTab("战士"):
		atkInfo.castCha.plusHp(atkInfo.finalVal * lvPer(lv,0.1))
