extends GemUn

func _data():
	name = "御伤石"
	tab = "坦克"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("每5层抵御 +%d%%增伤") % [per(4)]

func _in():
	masCha.connect("onCastHurtStart",self,"r")
	
func r(atkInfo):
	var bf = masCha.hasAff("b_a_diYu")
	if bf != null:
		atkInfo.per += per(0.04) * (bf.lv / 5)
