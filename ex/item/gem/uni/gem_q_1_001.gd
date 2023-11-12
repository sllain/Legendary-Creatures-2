extends GemUn

func _data():
	name = "血石"
	tab = "战士"
	isUnique = true
	
func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL:
		masCha.castBuff(atkInfo.cha,"b_b_liuXue",per(5))
	
func getDec():
	return tr("技能伤害附加%d层流血") % [per(5)]
	
