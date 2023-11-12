extends GemUn

func _data():
	name = "剧毒石"
	tab = "刺客"
	isUnique = true
	
func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL:
		masCha.castBuff(atkInfo.cha,"b_b_zhongDu",per(5))
	
func getDec():
	return tr("技能伤害附加%d层中毒") % [per(5)]
	
