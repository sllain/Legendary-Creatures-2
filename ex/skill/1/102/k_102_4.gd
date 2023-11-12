extends Skill

func _data():
	name = "破击晕"
	cd = 0
	tab = "钝器使"

func _in():
	masCha.connect("onCastBuff",self,"r")


func r(buff):
	if buff.id == "b_b_poJia" && sys.rndPer(per(0.5)):
		masCha.castBuff(buff.masCha,"b_b_xuanYun",3)
		hurt(buff.masCha,buff.masCha.maxHp * per(0.1),HURTTYPE.PHY,ATKTYPE.EFF)

func getDec():
	return tr("附加破甲时额外造成%d%%目标最大生命值的物理伤害并附加%d层眩晕") % [per(0.1) * 100,3]
