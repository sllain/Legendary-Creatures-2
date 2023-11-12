extends Skill

func _data():
	name = "元素亲和"
	cd = 0
	tab = "法师"

func getDec():
	return tr("施加负面状态时额外增加%d层") % per(8)

func _in():
	masCha.connect("onCastBuff",self,"r")

func r(buff:Buff):
	if buff.hasTab("deBuff"):
		buff.lv += per(8)

