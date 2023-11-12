extends Skill

func _data():
	name = "烈焰连打"
	cd = 0
	tab = "专属"

var bn = 8

func getDec():
	return tr("普通攻击%d%%的几率附加%d层烧灼，并且获得%d层狂怒和急速") % [per(40),5,bn]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL && rndPer(per(0.4)):
		masCha.castBuff(atkInfo.cha,"b_b_shaoZhuo",5)
		masCha.castBuff(masCha,"b_a_kuangNu",bn)
		masCha.castBuff(masCha,"b_a_jiSu",bn)
