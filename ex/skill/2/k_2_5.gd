extends Skill

func _data():
	name = "射手直觉"
	cd = 0
	self.ran = 1
	self.spd = 0.20
	tab = "射手"
	
func getDec():
	return tr("增加1点射程和%d%%的物理攻击和攻击速度") % [per(0.2) * 100]

func setLv(val):
	.setLv(val)
	self.spd = per(0.20)
	perMul("atk",per(0.2))
