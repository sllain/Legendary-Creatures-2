extends Skill

func _data():
	name = "冲击矢"
	cd = 0
	cri = 0.15
	tab = "专属"
	
func getDec():
	return tr("获得%d%%暴击率,暴击时附加%d层破甲") % [per(0.15) * 100,per(5)]

func setLv(val):
	.setLv(val)
	self.cri = per(0.15)

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(info):
	if info.isCri :
		masCha.castBuff(info.cha,"b_b_poJia",per(5))
