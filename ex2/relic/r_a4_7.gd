extends Relic

func _data():
	name = "潜伏"
	lock = 0
	
func getDec():
	return tr("刺客击杀单位后获得%d层隐身") % [lvPer(lv,5)]

func _in():
	sys.game.connect("onChaKill",self,"r")

func r(atkInfo):
	if atkInfo.castCha.team == sys.player.team && atkInfo.castCha.hasTab("刺客") :
		atkInfo.castCha.castBuff(atkInfo.castCha,"b_a_yinShen",per(5))
