extends GemUn

func _data():
	name = "破盾石"
	tab = "战士"
	isUnique = true
	
func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType != ATKTYPE.EFF:
		if atkInfo.cha.ward > 0 :
			atkInfo.cha.ward -= atkInfo.finalVal * per(0.5)
	
func getDec():
	return tr("对护盾造成额外%d%%的伤害") % [per(50)]
	
