extends GemUn

func _data():
	name = "斩杀石"
	tab = "刺客"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("对生命值低于30%%的目标，+%d%%增伤") % [per(30)]
	
func _in():
	masCha.connect("onCastHurtStart",self,"r")
	
func r(atkInfo):
	if atkInfo.cha.hp/atkInfo.cha.maxHp <= 0.3:
		atkInfo.per += per(0.3)
