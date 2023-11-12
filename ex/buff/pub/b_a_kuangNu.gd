extends PubBuff

func _data():
	name = "狂怒"
	isDie = false
	isLong = false

	tab = "buff"
	effId = "e_buffKuangNu"

func setLv(val):
	.setLv(val)
	perAdd("atk",per(0.3))

func getDec():
	return tr("物理攻击提高 %d%%，最高 %d%%") % [per(0.3) * 100,lvPer(maxLv,0.3) * 100]
