extends GemUn

func _data():
	name = "猛击石"
	tab = "坦克"
	isUnique = true
	lock = 0

func getDec():
	return tr("普攻附带%d%%护盾量的物理伤害") % [per(30)]

func _in():
	masCha.connect("onCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL and masCha.ward > 0:
		hurt(atkInfo.cha,masCha.ward * per(0.3),HURTTYPE.PHY,ATKTYPE.EFF)
