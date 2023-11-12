extends Skill

func _data():
	name = "快速上膛"
	cd = 0
	cri = 0.25
	tab = "专属"
	
func getDec():
	return tr("获得%d%%暴击率,暴击时减少%d%%所有技能冷却") % [per(0.15) * 100,per(10)]

func setLv(val):
	.setLv(val)
	self.cri = per(0.15)

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(info):
	if info.isCri :
		for i in masCha.skills.items:
			i.cdVal += per(0.1) * i.cd
