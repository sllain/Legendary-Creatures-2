extends PubBuff

func _data():
	name = "麻痹"
	isDie = true
	isLong = false
	tab = "deBuff"
	effId = "e_buffMabi"

func setLv(val):
	.setLv(val)
	self.cdSpd = - per(0.3)

func getDec():
	return tr("冷却速度减少 %d%%，最高 %d%%") % [per(0.3) * 100,lvPer(maxLv,0.3) * 100]
