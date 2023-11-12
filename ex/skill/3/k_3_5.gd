extends Skill

func _data():
	name = "坚定意志"
	cd = 0
	tab = "坦克"
	
func getDec():
	return tr("受到技能伤害时，减少%d%%所有主动技能当前冷却时间，并且获得%d层抵御") %  [7,per(7)]

func _in():
	masCha.connect("onHurtStart",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL :
		masCha.castBuff(masCha,"b_a_diYu",5)
		for i in masCha.skills.items:
			if i.cd > 0 :
				i.cdVal *= 1 - 0.05
