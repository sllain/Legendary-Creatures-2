extends Skill

func _data():
	name = "黏糊身躯"
	cd = 0
	tab = "专属"
	
func getDec():
	return tr("被附加烧灼，中毒时,免疫 并有%d%%的几率回复%d%%的生命值") % [40,per(5)]

func _in():
	masCha.connect("onAddBuff",self,"r")

func r(buff):
	if buff.id == "b_b_shaoZhuo" || buff.id == "b_b_zhongDu":
		masCha.delAff(buff)
		if rndPer(0.4) :
			plusHp(masCha.maxHp * per(0.05))
