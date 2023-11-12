extends GemUn

func _data():
	name = "铸甲石"
	tab = "坦克"
	isUnique = true

func setLv(val):
	.setLv(val)
	perAdd("def",per(0.15))
	perAdd("mdef",per(0.15))

func getDec():
	return tr("双抗提升%d%%") % per(15)
