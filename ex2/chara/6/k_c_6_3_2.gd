extends Skill

func _data():
	name = "奉献"
	cd = 0
	tab = "专属"
	
func getDec():
	return tr("受到技能伤害时，使他以及最近的友方，获得%d%%最大生命值的护盾") %  [per(0.05) * 100]

func _in():
	masCha.connect("onHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL :
		plusWard(masCha.maxHp * per(0.05),masCha)
		var cha = masCha.getMinRanCha(2)
		if cha != null:
			plusWard(cha.maxHp * per(0.05),cha)

