extends Skill

func _data():
	name = "涂毒"
	cd = 0
	tab = "毒枭"

func getDec():
	return tr("技能伤害附加%d层中毒") % per(10)

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL :
		masCha.castBuff(atkInfo.cha,"b_b_zhongDu",per(10))
		
