extends Skill

func _data():
	name = "幽灵身躯"
	cd = 0
	tab = "专属"

func getDec():
	return tr("减少%d%%受到的物理伤害") % [per(20)]

func _in():
	masCha.connect("onHurtStart",self,"r")
	
func r(atkInfo):
	if atkInfo.hurtType == HURTTYPE.PHY :
		atkInfo.per -= per(0.2)
		
