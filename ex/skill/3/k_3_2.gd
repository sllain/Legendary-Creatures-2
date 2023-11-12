extends Skill

func _data():
	name = "坚守之姿"
	cd = 0
	tab = "坦克"
	
func getDec():
	return tr("减少%d%%受到的普攻伤害，如果是暴击，则双倍减伤") %  [per(0.3) * 100]

func _in():
	masCha.connect("onHurtStart",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL :
		if atkInfo.isCri :
			atkInfo.per -= per(0.3) * 2
		else:
			atkInfo.per -= per(0.3)

