extends Skill

func _data():
	name = "弓箭精通"
	cd = 0
	tab = "弓手"
	cri = 0.2
	
func getDec():
	return tr("获得%d%%暴击率，暴击伤害提高%d%%") % [per(0.20) * 100,per(0.2) * 100]

func setLv(val):
	.setLv(val)
	perAdd("criR",per(0.2))
	self.cri = per(0.2)
