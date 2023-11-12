extends GemUn

func _data():
	name = "普血石"
	tab = "射手"
	isUnique = true
	lock = 0

func getDec():
	return tr("普攻%d%%几率附加%d层流血") % [per(20),5]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL && rndPer(lvPer(lv,0.20)) :
		masCha.castBuff(atkInfo.cha,"b_b_liuXue",5)


