extends GemUn

func _data():
	name = "狂战石"
	tab = "战士"
	isUnique = true
	lock = 0

func getDec():
	return tr("每损失10%%生命值，技能伤害+%d%%") % per(10)
 
func _in():
	masCha.connect("onCastHurtStart",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL:
		atkInfo.per += per(0.1) * (masCha.hp / masCha.maxHp )

