extends Skill

func _data():
	name = "藏形匿影"
	cd = 8
	tab = "暗杀者"

func getDec():
	return tr("获得%d层隐身，%d层狂怒和急速") % [10,per(8)]

func _cast():
	masCha.castBuff(masCha,"b_a_yinShen",10)
	masCha.castBuff(masCha,"b_a_jiSu",per(8))
	masCha.castBuff(masCha,"b_a_kuangNu",per(8))

