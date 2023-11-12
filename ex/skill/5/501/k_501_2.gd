extends Skill

func _data():
	name = "冰晶增幅"
	tab = "冰法"
	cd = 0

func getDec():
	return tr("目标单位每2层结霜使你技能伤害提升%d%%") % per(6)

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL :
		var bf = atkInfo.cha.hasAff("b_b_jieShuang")
		if bf == null :return
		atkInfo.per += per(6) * bf.lv * 0.5
