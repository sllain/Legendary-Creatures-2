extends GemUn

func _data():
	name = "寒霜石"
	tab = "法师"
	isUnique = true
	
func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL:
		masCha.castBuff(atkInfo.cha,"b_b_jieShuang",per(5))

func getDec():
	return tr("技能伤害附加%d层结霜") % [per(5)]
	
