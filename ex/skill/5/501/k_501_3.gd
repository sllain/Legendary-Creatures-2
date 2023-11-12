extends Skill

func _data():
	name = "冻结"
	cd = 0
	tab = "冰法"
	
func getDec():
	return tr("对敌人附加结霜达到30层时，消除层数,造成%d%%的伤害，附加%d层眩晕") % [per(300),10]

func _in():
	masCha.connect("onCastBuff",self,"r")

func r(buff:Buff):
	if buff.id == "b_b_jieShuang" && buff.lv >= 30:
		masCha.castBuff(buff.masCha,"b_b_xuanYun",10)
		buff.lv -= 30
		hurtPerM(buff.masCha,per(3.0),ATKTYPE.EFF)

