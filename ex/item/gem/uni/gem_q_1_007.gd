extends GemUn

func _data():
	name = "力量石"
	tab = "战士 刺客"
	isUnique = true

func setLv(val):
	.setLv(val)
	perMul("atk",per(0.15))

func getDec():
	return tr("最终物理攻击增加%d%%") % per(15)
 
 
