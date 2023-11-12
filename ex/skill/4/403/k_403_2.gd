extends Skill

func _data():
	name = "狂暴疾风"
	cd = 0
	tab = "侠客"
	
func getDec():
	return tr("普攻时%d%%的几率获得%d层急速和狂怒") %  [40,per(5)]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL && sys.rndPer(0.4):
		masCha.castBuff(masCha,"b_a_jiSu",per(5))
		masCha.castBuff(masCha,"b_a_kuangNu",per(5))
