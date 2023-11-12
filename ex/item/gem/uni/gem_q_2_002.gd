extends GemUn

func _data():
	name = "细雪石"
	tab = "射手"
	isUnique = true
	
func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL:
		hurt(atkInfo.cha,atkInfo.cha.hp * per(0.05),HURTTYPE.PHY,ATKTYPE.EFF)

func getDec():
	return tr("普攻附加%d%%目标当前生命值的物理伤害") % [per(0.05) * 100]
