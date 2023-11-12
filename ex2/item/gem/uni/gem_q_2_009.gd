extends GemUn

func _data():
	name = "猎手石"
	tab = "射手"
	isUnique = true
	lock = 0

func getDec():
	return tr("每距离目标1格，+%d%%增伤") % [per(10)]

func _in():
	masCha.connect("onCastHurtStart",self,"r")
	
func r(atkInfo):
	atkInfo.per += per(0.1) * (abs(atkInfo.cha.cell.x-masCha.cell.x)+abs(atkInfo.cha.cell.y-masCha.cell.y))


