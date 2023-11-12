extends GemUn

func _data():
	name = "怒却石"
	tab = "战士 刺客"
	isUnique = true
	lock = 0

func getDec():
	return tr("受到技能伤害时，获得%d层超然") % per(5)
 
func _in():
	masCha.connect("onHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL:
		masCha.castBuff(masCha,"b_a_chaoRan",per(5))

