extends Skill

func _data():
	name = "驽精通"
	cd = 6
	tab = "弩手"
	
func getDec():
	return tr("获得%d层急速，无施法动作，冷却速度额外收益于攻击速度") % [per(15)]

func _cast():
	masCha.castBuff(masCha,"b_a_jiSu",per(15))

func _process(delta):
	._process(delta)
	if cd != 0 && masCha.yunTime <= 0:
		cdVal += mas.spd * delta
