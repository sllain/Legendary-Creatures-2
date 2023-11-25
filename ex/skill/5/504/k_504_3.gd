extends Skill

func _data():
	name = "奥能护盾"
	cd = 0
	tab = "魔武者"

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.EFF : return
	plusWard(atkInfo.finalVal * per(0.3))

func getDec():
	return tr("造成非被动伤害的%d%%转为护盾值") % per(30)

