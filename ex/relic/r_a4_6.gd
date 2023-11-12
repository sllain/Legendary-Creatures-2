extends Relic

func _data():
	name = "快速接敌"
	lock = 0
	
func getDec():
	return tr("刺客非被动伤害%d%%的概率获得%d层急速") % [lvPer(lv,30),lvPer(lv,5)]

func _in():
	sys.game.connect("onChaCastHurtStart",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team and atkInfo.atkType != ATKTYPE.EFF and atkInfo.castCha.hasTab("刺客"):
		if sys.rndPer(lvPer(lv,0.3)):
			atkInfo.castCha.castBuff(atkInfo.castCha,"b_a_jiSu",lvPer(lv,5))
