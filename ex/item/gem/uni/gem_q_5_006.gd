extends GemUn

func _data():
	name = "雷鸣石"
	tab = "法师"
	isUnique = true
	
func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL:
		masCha.castBuff(atkInfo.cha,"b_b_maBi",per(5))

func getDec():
	return tr("技能伤害附加%d层麻痹") % [per(5)]
	
