extends Skill

func _data():
	name = "利爪"
	cd = 0
	tab = "专属"

func getDec():
	return tr("普通攻击%d%%的几率附加5层流血和中毒") % per(30)

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL && rndPer(per(0.3)):
		masCha.castBuff(atkInfo.cha,"b_b_liuXue")
		masCha.castBuff(atkInfo.cha,"b_b_zhongDu")
