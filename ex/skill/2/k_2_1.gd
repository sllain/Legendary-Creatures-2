extends Skill

func _data():
	name = "弱点感知"
	cd = 0
	tab = "射手"

func _in():
	masCha.connect("onCastHurtStart",self,"r")

func r(atkInfo):
	atkInfo.per += clamp(atkInfo.cha.hp,0.1,999999) / clamp(masCha.hp,0.1,999999) * per(0.30)

func getDec():
	return tr("对手生命值每高你一倍获得%d%%的增伤") % per(30)
