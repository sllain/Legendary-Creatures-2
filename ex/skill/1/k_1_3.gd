extends Skill

func _data():
	name = "武器大师"
	cd = 0
	tab = "战士"

func _in():
	masCha.connect("onNormAtk",self,"r")

func r():
	for i in masCha.skills.items:
		i.cdVal += per(0.15) * i.cd

func getDec():
	return tr("普通攻击减少所有主动技能%d%%的冷却") % [per(15)]
