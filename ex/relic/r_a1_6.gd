extends Relic

func _data():
	name = "不屈之魂"
	
func getDec():
	return tr("战士的血量低于50%%时，获得%d%%的减伤") % [lvPer(lv,30)]
	
func _in():
	sys.game.connect("onChaHurtStart",self,"r")

func r(atkInfo):
	if atkInfo.cha.team == sys.player.team and atkInfo.castCha.hasTab("战士"):
		if atkInfo.cha.hp / atkInfo.cha.maxHp <= 0.5:
			atkInfo.per -= lvPer(lv,0.3)
