extends Skill

func _data():
	name = "骨甲"
	cd = 0
	tab = "专属"
func getDec():
	return tr("生命值大于60%%时，获得%d%%的减伤") %  [per(0.3) * 100]

func _in():
	masCha.connect("onHurtStart",self,"r")
	
func r(atkInfo):
	if masCha.hp / masCha.maxHp > 0.6:
		atkInfo.per -= per(0.3)
			
