extends Skill

func _data():
	name = "电磁力场"
	cd = 0
	tab = "专属"
	
func getDec():
	return tr("减少%d%%周围1格敌人对你的伤害，并且他们对你的普通攻击%d%%的几率使他们附着%d层麻痹") % [per(20),30,per(5)]

func _in():
	masCha.connect("onHurtStart",self,"r")
	
func r(info):
	if masCha.distanceTo(info.castCha) <= 1 :
		info.per -= per(0.2)
		if info.atkType == ATKTYPE.NORMAL && rndPer(0.3):
			masCha.castBuff(info.castCha,"b_b_maBi",per(5))
