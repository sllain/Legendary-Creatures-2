extends Skill

func _data():
	name = "快速上弦"
	cd = 0
	tab = "射手"
	spd = 0
	
func getDec():
	return tr("每次对同一目标普攻时，+%d%%攻速，切换目标后重置，最高提升%d%%") % [per(0.1) * 100,per(200)]

func _in():
	masCha.connect("onNormAtk",self,"r")
	self.spd = 0

var oldCha = null
func r():
	if masCha.aiCha == oldCha :
		if self.spd < per(2) :
			self.spd += per(0.1)
	else:
		self.spd = 0
		oldCha = masCha.aiCha

