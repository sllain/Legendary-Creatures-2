extends GemUn

func _data():
	name = "转能石"
	tab = "战士"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("造成技能伤害时，获得%d%%伤害量的护盾") % [per(15)]
	
func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType != ATKTYPE.SKILL :return
	plusWard(atkInfo.finalVal * per(0.15))
