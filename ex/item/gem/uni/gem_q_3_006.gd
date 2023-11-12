extends GemUn

func _data():
	name = "生命石"
	tab = "坦克"
	isUnique = true

func setLv(val):
	.setLv(val)
	perAdd("maxHp",per(0.2))

func getDec():
	return tr("最大生命值提升%d%%") % per(20)
