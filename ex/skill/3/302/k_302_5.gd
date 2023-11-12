extends Skill

func _data():
	name = "反能铠"
	cd = 0
	tab = "重甲士"
	
func getDec():
	return tr("受到技能伤害时,+%d%% 对技能的减伤，并获得%d层抵御") %  [per(35),per(5)]

func _in():
	masCha.connect("onHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL :
		atkInfo.per -= per(0.35)
		masCha.castBuff(masCha,"b_a_diYu",per(5))
