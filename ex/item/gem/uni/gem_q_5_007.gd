extends GemUn

func _data():
	name = "法爆石"
	tab = "刺客"
	isUnique = true
	
func getDec():
	return tr("技能可以暴击")

func _in():
	masCha.connect("onCastHurtStart",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL :
		atkInfo.canCri = true
		
