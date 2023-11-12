extends PubBuff

func _data():
	name = "威能"
	isDie = false
	isLong = false

	tab = "buff"
	effId = "e_buffKuangNu"

func setLv(val):
	.setLv(val)
	perAdd("matk",per(0.3))

func getDec():
	return tr("魔法攻击提高 %d%%，最高 %d%%") % [per(0.3) * 100,lvPer(maxLv,0.3) * 100]
