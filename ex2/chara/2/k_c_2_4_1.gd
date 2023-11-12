extends Skill

func _data():
	name = "精弩"
	cd = 0
	tab = "专属"

func getDec():
	return tr("普通攻击%d%%的几率获得5层急速") % per(40)

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL && rndPer(per(0.4)):
		masCha.castBuff(masCha,"b_a_jiSu")
