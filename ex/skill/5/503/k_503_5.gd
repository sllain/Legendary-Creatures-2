extends Skill

func _data():
	name = "电能过载"
	cd = 0
	tab = "雷法"
	self.cdSpd = 0.0
	
func getDec():
	return tr("本场战斗每释放1次主动技能，提高%d%%冷却速度") % [per(0.05)*100]

func _in():
	masCha.connect("onCastSkill",self,"r")
	self.cdSpd = 0.0

func r(sk):
	self.cdSpd += per(0.05)

