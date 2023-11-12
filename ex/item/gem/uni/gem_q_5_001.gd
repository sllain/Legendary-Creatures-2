extends GemUn

func _data():
	name = "魔能石"
	tab = "法师"
	isUnique = true

func setLv(val):
	.setLv(val)
	perMul("matk",per(0.15))

func getDec():
	return tr("最终魔法攻击增加%d%%") % per(15)
 

