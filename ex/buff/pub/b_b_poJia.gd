extends PubBuff

func _data():
	name = "破甲"
	isDie = true
	isLong = false

	tab = "deBuff"
	effId = "e_buffPoJia"

func setLv(val):
	.setLv(val)
	perAdd("def",- per(0.3))
	perAdd("mdef",- per(0.3))
	
func getDec():
	return tr("物理和魔法防御减少 %d%%，最高 %d%%") % [per(0.3) * 100,lvPer(maxLv,0.3) * 100]
