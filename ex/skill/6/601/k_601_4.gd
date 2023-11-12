extends Skill

func _data():
	name = "双重加持"
	cd = 0
	tab = "牧师"

func getDec():
	return tr("施放治疗时使目标获得%d%%该值的护盾") % per(60)

func _in():
	masCha.connect("onCastPlus",self,"r")

func r(info):
	if info.type == "hp" :
		masCha.plusWard(info.finalVal * per(0.60),info.cha)

