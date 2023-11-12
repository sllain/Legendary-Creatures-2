extends Skill

func _data():
	name = "整装待发"
	cd = 0
	tab = "火枪手"

func getDec():
	return tr("每15%%暴击率可以提升%d%%伤害") % [per(0.10)*100]

func _in():
	masCha.connect("onCastHurtStart",self,"r")

func r(atkInfo):
	if masCha.cri > 0.0:
		atkInfo.per += per(0.10) * (masCha.cri / 0.15)
