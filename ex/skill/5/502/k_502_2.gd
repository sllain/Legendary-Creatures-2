extends Skill

func _data():
	name = "点燃"
	tab = "火法"
	cd = 0

func getDec():
	return tr("对敌人附加烧灼时，造成%d%%的魔法伤害，每层伤害提高%d%%") % [per(100),3]


func _in():
	masCha.connect("onCastBuff",self,"r")

func r(buff:Buff):
	if buff.id == "b_b_shaoZhuo":
		hurtPerM(buff.masCha,per(1.0) * lvPer(buff.lv,1,0.03),ATKTYPE.EFF)

