extends GemUn

func _data():
	name = "怒伤石"
	tab = "战士"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("每5层狂怒 +%d%%增伤") % [per(5)]

func _in():
	masCha.connect("onCastHurtStart",self,"r")
	
func r(atkInfo):
	var bf = masCha.hasAff("b_a_kuangNu")
	if bf != null:
		atkInfo.per += per(0.05) * (bf.lv / 5)
