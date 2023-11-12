extends Skill

func _data():
	name = "注魔兵刃"
	cd = 0
	tab = "魔武者"

func getDec():
	return tr("普攻附加%d%%的魔法伤害") % [per(0.50)*100]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL:
		hurtPerM(masCha.aiCha,per(0.50),ATKTYPE.EFF)

