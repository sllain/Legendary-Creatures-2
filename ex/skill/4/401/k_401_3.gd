extends Skill

func _data():
	name = "瞄准死穴"
	cd = 0
	tab = "忍者"

func getDec():
	return tr("每10%%的暴击率，提高%d%%的技能伤害") % (per(10))
var val = 0.0
func _in():
	masCha.connect("onCastHurtStart",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.SKILL:
		atkInfo.per += masCha.cri * per(1.0)
