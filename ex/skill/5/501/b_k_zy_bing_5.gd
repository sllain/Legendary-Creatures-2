extends Buff

func _data():
	name = "冰霜附魔"
	isDie = false
	isLong = false
	
	tab = "buff"
	lock = -1

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL :
		hurtPerM(atkInfo.cha,lvPer(lv,0.3),ATKTYPE.EFF)
		masCha.castBuff(atkInfo.cha,"b_b_jieShuang",3)

func getDec():
	return tr("普攻附加%d%%魔法伤害，3层结霜") % lvPer(lv,0.3)
