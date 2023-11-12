extends Relic

func _data():
	name = "横尸游刃"
	
func getDec():
	return tr("刺客在击杀后，获得%d层 急速和超然") % [lvPer(lv,10)]

func _in():
	sys.game.connect("onChaKill",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.castCha.hasTab("刺客"):
		atkInfo.castCha.castBuff(atkInfo.castCha,"b_a_jiSu",lvPer(lv,10))
		atkInfo.castCha.castBuff(atkInfo.castCha,"b_a_chaoRan",lvPer(lv,10))
