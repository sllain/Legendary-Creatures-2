extends Relic

func _data():
	name = "锯齿之刃"
	
func getDec():
	return tr("战士的普攻%d%%的概率附加%d层流血") % [lvPer(lv,40),lvPer(lv,5)]
	
func _in():
	sys.game.connect("onChaCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team and atkInfo.atkType == ATKTYPE.NORMAL and atkInfo.castCha.hasTab("战士"):
		if sys.rndPer(lvPer(lv,0.4)):
			atkInfo.castCha.castBuff(atkInfo.cha,"b_b_liuXue",lvPer(lv,5))
