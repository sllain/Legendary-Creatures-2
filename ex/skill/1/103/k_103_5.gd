extends Skill

func _data():
	name = "暴怒"
	cd = 0
	tab = "狂战士"

var hpv = 0.0

func _in():
	masCha.connect("onHurt",self,"r")
	self.atk = 0
	
func r(atkInfo):
	hpv += atkInfo.val
	if hpv >= masCha.maxHp * 0.15 && self.atk < per(200):
		self.atk += per(15)
		hpv = 0.0

func getDec():
	return tr("本场战斗：每承受15%%的最大生命值的伤害，+%d点攻击，最高%d点") % [ per(15),per(200)]

