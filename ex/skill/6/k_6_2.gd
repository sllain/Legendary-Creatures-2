extends Skill

func _data():
	name = "忠诚信仰"
	cd = 0
	tab = "辅助"

func getDec():
	return tr("施放的治疗和护盾效果提升%d%%") % per(30)

func _in():
	masCha.connect("onCastPlusStart",self,"r")

func r(info):
	info.per += per(0.3)

