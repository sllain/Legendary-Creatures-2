extends Skill

func _data():
	name = "学识丰富"
	cd = 0
	tab = "法师"

func _in():
	masCha.connect("onCastSkill",self,"r")

func getDec():
	return tr("施放技能时获得%d层超然") % [per(8)]

func r(skill):
	masCha.castBuff(masCha,"b_a_chaoRan",per(8))
