extends Buff

func _data():
	name = "火焰附魔"
	isDie = false
	isLong = true
	tab = "buff"
	lock = -1

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL :
		castCha.hurt(atkInfo.cha,lvPer(lv,0.4,0.2) * castCha.matk,HURTTYPE.MAG,ATKTYPE.EFF)
		if rndPer(0.3) : castCha.castBuff(atkInfo.cha,"b_b_shaoZhuo",per(5))
		
func getDec():
	return tr("普攻附加%d%%魔法伤害，%d%%的几率附加%d层烧灼") % [per(40),30,per(5)]
