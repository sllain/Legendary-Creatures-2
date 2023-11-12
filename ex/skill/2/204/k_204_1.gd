extends Skill

func _data():
	name = "高速射击"
	cd = 0
	tab = "弩手"
	spd = 0
	
func getDec():
	return tr("每%d次普通攻击攻速提高%d%%，持续到战斗结束") % [3,per(0.06) * 100]

func _in():
	masCha.connect("onNormAtk",self,"r")
	self.spd = 0
	atkn = 0

var atkn = 0
func r():
	atkn += 1 
	if atkn >= 3 :
		self.spd += per(0.06)
		atkn = 0
