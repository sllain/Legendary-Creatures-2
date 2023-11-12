extends PubBuff

func _data():
	name = "超然"
	isDie = false
	isLong = false
	tab = "buff"
	effId = "e_buffChaoRan"

func setLv(val):
	.setLv(val)
	self.cdSpd = per(0.3)

func getDec():
	return tr("冷却速度提高 %d%%，最高 %d%%") % [per(0.3) * 100,lvPer(maxLv,0.3) * 100]
