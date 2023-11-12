extends Skill

func _data():
	name = "斩铁"
	cd = 0
	tab = "刺客"
	pen = 15
	perAdd("pen",0.3)

func getDec():
	return tr("+%d穿甲，并提高30%%的穿甲") % per(15)

func setLv(val):
	.setLv(val)
	self.pen = per(15)
