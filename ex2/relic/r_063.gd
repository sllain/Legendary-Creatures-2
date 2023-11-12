extends Relic

func _data():
	name = "虚空盾"
	
func getDec():
	return tr("我方拥有护盾的单位，获得%d%%减伤") % [lvPer(lv,15)]

func _in():
	sys.game.connect("onChaHurtStart",self,"r")

func r(atkInfo):
	if atkInfo.cha.team == sys.player.team and atkInfo.cha.ward > 0:
		atkInfo.per -= lvPer(lv,0.15)
	
