extends Skill

func _data():
	name = "持盾防守"
	cd = 0
	tab = "盾卫"

func getDec():
	return tr("每承受30%%最大生命值的伤害,获得 %d%%最大生命值的护盾") % per(0.09 * 100)

var bval = 0
func _in():
	bval = 0
	masCha.connect("onHurt",self,"r")
	
func r(atkInfo):
	bval += atkInfo.finalVal 
	if bval >= masCha.maxHp * 0.3:
		plusWard(masCha.maxHp * per(0.09))
		bval = 0

