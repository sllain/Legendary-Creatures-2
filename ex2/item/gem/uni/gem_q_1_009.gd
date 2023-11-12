extends GemUn

func _data():
	name = "震荡石"
	tab = "战士 刺客"
	isUnique = true
	lock = 0

func getDec():
	return tr("暴击时%d%%概率使目标眩晕%d层") % [per(20),5]
 
func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.isCri and rndPer(per(0.2)):
		masCha.castBuff(atkInfo.cha,"b_b_xuanYun",5)

