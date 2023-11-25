extends Skill

func _data():
	name = "炎之甲"
	cd = 0
	tab = "专属"

func getDec():
	return tr("免疫烧灼，获得%d%%的魔法物理防御；受到技能伤害时，对攻击者施加%d层烧灼，自身获得%d层抵御") % [per(30),per(5),per(5)]

func _in():
	masCha.connect("onAddBuff",self,"r")
	masCha.connect("onHurt",self,"r2")

func r(buff):
	if buff.id == "b_b_shaoZhuo":
		buff.del()

func r2(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL:
		masCha.castBuff(atkInfo.castCha,"b_b_shaoZhuo",per(5))
		masCha.castBuff(masCha,"b_a_diYu",per(5))
		
func setLv(val):
	.setLv(val)
	reset()

func reset():
	self.def = 0
	perAdd("mdef",per(0.3))
