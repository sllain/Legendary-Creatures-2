extends GemUn

func _data():
	name = "夺萃石"
	tab = "战士 刺客"
	isUnique = true
	lock = 0

func getDec():
	return tr("击杀敌人时，回复%d%%已损失生命值") % per(20)
 
func _in():
	masCha.connect("onKill",self,"r")
	
func r(atkInfo):
	plusHp((masCha.maxHp-masCha.hp)*per(0.2))
