extends GemUn

func _data():
	name = "吸血技石"
	tab = "战士 刺客"
	isUnique = true

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL:
		plusHp(atkInfo.finalVal * per(0.1))

func getDec():
	return tr("技能伤害获得%d%%吸血") % per(10)
