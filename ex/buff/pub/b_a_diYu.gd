extends PubBuff

func _data():
	name = "抵御"
	isDie = false
	isLong = false
	tab = "buff"
	effId = "e_buffDiYu"
	

func setLv(val):
	.setLv(val)
	perAdd("mdef",per(0.3))
	perAdd("def",per(0.3))
  
func getDec():
	return tr("物理和魔法防御提高 %d%%，最高 %d%%") % [per(0.3) * 100,lvPer(maxLv,0.3) * 100]
