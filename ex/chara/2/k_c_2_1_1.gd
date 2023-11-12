extends Skill

func _data():
	name = "精装弓矢"
	cd = 0
	cri = 0.15
	tab = "专属"

func setLv(val):
	.setLv(val)
	self.cri = per(0.2)

func getDec():
	return tr("获得%d%%暴击率，暴击时获得%d层急速") % [per(0.2) * 100,per(8)]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(info):
	if info.isCri == true:
		masCha.castBuff(masCha,"b_a_jiSu",per(8))
