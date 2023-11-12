extends Skill

func _data():
	name = "力大开弓"
	cd = 0
	tab = "弓手"
	cri = 0
	
func getDec():
	return tr("对敌方附加破甲时，本场战斗 + %d%%的暴击率") % [per(0.06) * 100]

func _in():
	masCha.connect("onCastBuff",self,"r")
	self.cri = 0.0
	
func r(buff):
	if buff.id == "b_b_poJia" :
		self.cri += per(0.06)
