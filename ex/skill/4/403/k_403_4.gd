extends Skill

func _data():
	name = "影镰"
	cd = 0
	tab = "侠客"

func getDec():
	return tr("普攻附加%d%%的物理伤害") % [per(0.7)*100]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL:
		hurtPerP(masCha.aiCha,per(0.7),ATKTYPE.EFF)

