extends GemUn

func _data():
	name = "速石"
	tab = "射手 刺客"
	isUnique = true
	
func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.isCri && rndPer(0.4):
		masCha.castBuff(masCha,"b_a_jiSu",per(5))

func getDec():
	return tr("暴击时，40%%几率获得%d层急速") % [per(5)]
