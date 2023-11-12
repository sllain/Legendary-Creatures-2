extends Relic

func _data():
	name = "龟甲"
	lock = 0
	
func getDec():
	return tr("我方获得%d%%减伤，但减少%d%%的增伤") % [lv*15,lv * 5]

func _in():
	sys.game.connect("onChaHurtStart",self,"r")

func r(atkInfo):
	if atkInfo.cha.team == sys.player.team:
		atkInfo.per -= lv * 0.15
	if atkInfo.castCha.team == sys.player.team :
		atkInfo.per -= lv * 0.05
