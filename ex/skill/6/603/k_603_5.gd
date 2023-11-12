extends Skill

var dmg = 0

func _data():
	name = "神圣壁垒"
	cd = 0
	tab = "圣骑士"
	
func getDec():
	return tr("拥有护盾时，获得%d%%减伤") %  [per(0.4)*100]

func _in():
	masCha.connect("onHurtStart",self,"r")
	
func r(atkInfo):
	if masCha.ward > 0:
		atkInfo.per -= per(0.4)
