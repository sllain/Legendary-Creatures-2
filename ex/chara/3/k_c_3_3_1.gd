extends Skill

func _data():
	name = "食腐"
	cd = 0
	tab = "专属"

func getDec():
	return tr("每有单位死亡，回复%d%%生命值") % (per(15))

func _in():
	sys.game.connect("onChaDeath",self,"r")
	
func r(atkInfo):
	plusHp(masCha.maxHp * per(0.15))
