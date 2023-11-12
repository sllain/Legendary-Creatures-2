extends GemUn

func _data():
	name = "普裂石"
	tab = "射手"
	isUnique = true

func getDec():
	return tr("普攻%d%%几率附加%d层破甲") % [per(20),5]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL && rndPer(lvPer(lv,0.20)) :
		masCha.castBuff(atkInfo.cha,"b_b_poJia",5)

