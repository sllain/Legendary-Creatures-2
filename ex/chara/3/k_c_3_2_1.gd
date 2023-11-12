extends Skill

func _data():
	name = "冰之甲"
	cd = 0
	tab = "专属"

func getDec():
	return tr("免疫结霜，获得%d%%的物理防御；受到普攻时，30%%概率对攻击者施加%d层结霜，且自身获得%d层抵御") % [per(30),per(5),per(5)]

func _in():
	masCha.connect("onAddBuff",self,"r")
	masCha.connect("onHurt",self,"r2")

func r(buff):
	if buff.id == "b_b_jieShuang":
		masCha.delAff(buff)

func r2(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL && rndPer(0.3):
		masCha.castBuff(atkInfo.castCha,"b_b_jieShuang",per(5))
		masCha.castBuff(masCha,"b_a_diYu",per(5))

func setLv(val):
	.setLv(val)
	reset()

func reset():
	self.def = 0
	perAdd("def",per(0.3))
