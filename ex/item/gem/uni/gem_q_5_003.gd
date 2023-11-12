extends GemUn

func _data():
	name = "法伤石"
	tab = "法师"
	isUnique = true
	
func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL:
		hurt(atkInfo.cha,atkInfo.cha.maxHp * per(0.05),HURTTYPE.MAG,ATKTYPE.EFF)

func getDec():
	return tr("技能附加目标%d%%最大生命值的魔法伤害") % per(5)
