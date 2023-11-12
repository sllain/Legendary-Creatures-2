extends Skill

func _data():
	name = "法能盾"
	cd = 0
	tab = "辅助"

func getDec():
	return tr("施放技能时，使最虚弱的友方获得%d%%魔法攻击的护盾值") % per(1.0*100)

func _in():
	masCha.connect("onCastSkill",self,"r")

func r(skill):
	var xcha = masCha.getWeakCha(2)
	masCha.plusWard(masCha.matk * per(1.0),xcha)

