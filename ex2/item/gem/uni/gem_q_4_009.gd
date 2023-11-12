extends GemUn

func _data():
	name = "狩猎石"
	tab = "刺客"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("击杀敌人时，获得%d层狂怒和急速") % [per(10)]
	
func _in():
	masCha.connect("onKill",self,"r")
	
func r(atkInfo):
	masCha.castBuff(masCha,"b_a_kuangNu",per(10))
	masCha.castBuff(masCha,"b_a_jiSu",per(10))
