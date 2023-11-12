extends GemUn

func _data():
	name = "击杀石"
	tab = "刺客"
	isUnique = true
	self.atk = 0
	lock = 0
	
func _in():
	masCha.connect("onKill",self,"r")
	self.atk = 0
	
func r(atkInfo):
	self.atk += per(10)
	
func getDec():
	return tr("本场战斗每个击杀+%d点物理攻击") % [per(10)]
	
