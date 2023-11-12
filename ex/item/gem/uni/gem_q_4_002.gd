extends GemUn

func _data():
	name = "吸血石"
	tab = "刺客 战士"
	isUnique = true

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL:
		masCha.plusHp(atkInfo.finalVal * per(0.1))

func getDec():
	return tr("普攻伤害获得%d%%吸血") % per(10)
