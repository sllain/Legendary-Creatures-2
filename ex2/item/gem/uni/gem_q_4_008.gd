extends GemUn

func _data():
	name = "无极石"
	tab = "刺客 射手"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("暴击时，附加一次%d%%伤害量的真实伤害") % [per(15)]
	
func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.isCri :
		hurt(atkInfo.cha,atkInfo.finalVal * per(0.15),HURTTYPE.REAL,ATKTYPE.EFF)
