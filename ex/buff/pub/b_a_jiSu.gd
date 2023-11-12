extends PubBuff

func _data():
	name = "急速"
	isDie = false
	isLong = false

	tab = "buff"
	effId = "e_buffJiSu"

func setLv(val):
	.setLv(val)
	self.spd = per(0.3)
	
func getDec():
	return tr("攻击速度提高 %d%%，最高 %d%%") % [per(0.3) * 100,lvPer(maxLv,0.3) * 100]
