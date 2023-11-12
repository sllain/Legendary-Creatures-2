extends Skill

func _data():
	name = "流线矢"
	cd = 0
	tab = "弩手"

var atkp = 1.0

func getDec():
	return tr("普通攻击%d%%的几率额造成%d%%的真实伤害，且获得%d层急速") % [per(50),atkp * 100,5]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL && rndPer(per(0.5)) :
		masCha.castBuff(masCha,"b_a_jiSu",5)
		hurtPer(atkInfo.cha,atkp,HURTTYPE.REAL,ATKTYPE.EFF)
