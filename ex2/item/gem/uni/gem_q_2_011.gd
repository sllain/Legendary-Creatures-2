extends GemUn

func _data():
	name = "速伤石"
	tab = "射手"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("每5层急速 +%d%%增伤") % [per(5)]

func _in():
	masCha.connect("onCastHurtStart",self,"r")
	
func r(atkInfo):
	var bf = masCha.hasAff("b_a_jiSu")
	if bf != null:
		atkInfo.per += per(0.05) * (bf.lv / 5)
