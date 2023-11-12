extends Skill

func _data():
	name = "潜能激荡"
	cd = 0
	tab = "辅助"

func getDec():
	return tr("施加增益状态和负面状态时，额外增加%d层") % per(8)

func _in():
	masCha.connect("onCastBuff",self,"r")

func r(buff:Buff):
	if buff.hasOrTab("buff deBuff"):
		buff.lv += per(8)

