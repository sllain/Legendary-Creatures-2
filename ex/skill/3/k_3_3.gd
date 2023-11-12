extends Skill

func _data():
	name = "反击之势"
	cd = 0
	tab = "坦克"
	
func getDec():
	return tr("普通攻击能够嘲讽敌人，并有30%%的概率附加%d层眩晕") %  [per(5)]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType  == ATKTYPE.NORMAL && rndPer(0.3):
		atkInfo.cha.aiCha = masCha
		masCha.castBuff(atkInfo.cha,"b_b_xuanYun",5)
	
