extends GemUn

func _data():
	name = "血伤石"
	tab = "战士"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("目标每5层流血 +%d%%增伤") % [per(5)]

func _in():
	masCha.connect("onCastHurtStart",self,"r")
	
func r(atkInfo):
	var bf = atkInfo.cha.hasAff("b_b_liuXue")
	if bf != null:
		atkInfo.per += per(0.05) * (bf.lv / 5)
