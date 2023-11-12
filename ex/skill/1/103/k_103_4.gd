extends Skill

func _data():
	name = "浴血奋战"
	cd = 0
	tab = "狂战士"
	
func getDec():
	return tr("根据剩余生命值最高获得%d%%的增伤和减伤") %  [per(50)]

func _in():
	masCha.connect("onHurtStart",self,"r")
	masCha.connect("onCastHurtStart",self,"r2")

func r(atkInfo):
	atkInfo.per -= (1 - masCha.hp / masCha.maxHp) * per(0.5)

func r2(atkInfo):
	atkInfo.per += (1 - masCha.hp / masCha.maxHp) * per(0.5)
