extends GemUn

func _data():
	name = "法锋石"
	tab = "法师"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("普通攻击附带%d%%法强的物理伤害") % [per(50)]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL:
		hurt(atkInfo.cha,masCha.matk * per(0.5),HURTTYPE.PHY,ATKTYPE.EFF)
