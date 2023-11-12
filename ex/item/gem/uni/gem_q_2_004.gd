extends GemUn

func _data():
	name = "爆裂石"
	tab = "射手 刺客"
	isUnique = true

func setLv(val):
	.setLv(val)
	perAdd("criR",per(0.2))

func getDec():
	return tr("暴击伤害提升%d%%") % per(20)
