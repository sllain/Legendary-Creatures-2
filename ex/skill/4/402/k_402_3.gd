extends Skill

func _data():
	name = "毒爪"
	cd = 0
	tab = "毒枭"

func getDec():
	return tr("普攻%d%%几率附加%d层中毒") % [per(40),per(5)]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL && rndPer(0.4) :
		masCha.castBuff(atkInfo.cha,"b_b_zhongDu",per(5))

