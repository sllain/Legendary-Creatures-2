extends Skill

func _data():
	name = "猎人之眼"
	cd = 0
	cri = 0.2
	self.spd = 0.2
	tab = "射手"
	
func getDec():
	return tr("获得%d%%暴击率和攻速加成") % [per(0.2) * 100]

func setLv(val):
	.setLv(val)
	self.cri = per(0.2)
	self.spd = per(0.2)
