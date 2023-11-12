extends GemUn

func _data():
	name = "麻伤石"
	tab = "刺客"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("目标每5层麻痹 +%d%%增伤") % [per(6)]

func _in():
	masCha.connect("onCastHurtStart",self,"r")
	
func r(atkInfo):
	var bf = atkInfo.cha.hasAff("b_b_maBi")
	if bf != null:
		atkInfo.per += per(0.06) * (bf.lv / 5)
