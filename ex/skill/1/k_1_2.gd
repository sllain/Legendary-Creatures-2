extends Skill

func _data():
	name = "以战养战"
	cd = 0
	tab = "战士"

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	plusHp(atkInfo.finalVal * per(0.30))

func getDec():
	return tr("获得%d%%全能吸血") % per(30)

