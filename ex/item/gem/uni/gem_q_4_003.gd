extends GemUn

func _data():
	name = "超然石"
	tab = "刺客 法师 辅助"
	isUnique = true
	
func _in():
	masCha.connect("onCastSkill",self,"r")
	
func r(skill):
	if rndPer(0.5) :
		masCha.castBuff(masCha,"b_a_chaoRan",per(5))

func getDec():
	return tr("施放技能时，50%%的几率获得%d层超然") % [per(5)]
	
