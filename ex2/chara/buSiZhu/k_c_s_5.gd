extends Skill

func _data():
	name = "凶镰"
	cd = 0
	tab = "专属"
func getDec():
	return tr("技能附加%d%%物理伤害,普攻附加%d%%的魔法伤害") %  [per(120),per(60)]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL :
		hurtPerM(atkInfo.cha,per(0.6),ATKTYPE.EFF)
	elif atkInfo.atkType == ATKTYPE.SKILL :
		hurtPerP(atkInfo.cha,per(1.2),ATKTYPE.EFF)
	
