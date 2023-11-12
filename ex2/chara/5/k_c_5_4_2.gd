extends Skill

func _data():
	name = "贯穿枪伤"
	cd = 0
	tab = "专属"

func getDec():
	return tr("普攻和特效伤害提高%d%%，并且普攻额外命中一个单位") % [per(0.3)*100]

func _in():
	masCha.connect("onCastHurt",self,"r")
	masCha.connect("onNormAtk",self,"r2")
	
func r(atkInfo):
	if atkInfo.atkType != ATKTYPE.SKILL and atkInfo.finalVal != 0:
		atkInfo.per += per(0.3)

func r2():
	var chas = masCha.getMinRanChas(1,2)
	for i in chas:
		if i != null && i != masCha.aiCha:
			hurtPerP(i,per(1.0),ATKTYPE.NORMAL)
			
