extends PubBuff

func _data():
	name = "结霜"
	isDie = true
	isLong = false
	tab = "deBuff"
	effId = "e_buffJieShuang"

func setLv(val):
	.setLv(val)
	self.spd = - per(0.3)

func getDec():
	return tr("普攻速度减少 %d%%，最高 %d%%") % [per(0.3) * 100,lvPer(maxLv,0.3) * 100]
