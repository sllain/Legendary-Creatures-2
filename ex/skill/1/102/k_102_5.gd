extends Skill

func _data():
	name = "锤精通"
	cd = 0
	tab = "钝器使"

func getDec():
	return tr("施加破甲时，自身获得%d%%物理攻击的护盾和%d层抵御") % [per(50),per(5)]

func _in():
	masCha.connect("onCastBuff",self,"r")

func r(bf):
	if bf.id == "b_b_poJia":
		masCha.castBuff(masCha,"b_a_diYu",per(5))
		masCha.plusWard(masCha.atk * per(0.5))
