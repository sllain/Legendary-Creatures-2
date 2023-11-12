extends Skill

func _data():
	name = "精巧打击"
	cd = 0
	tab = "忍者"

func getDec():
	return tr("普攻暴击时附加%d%%的物理伤害") % [per(150)]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(atkInfo):
	if atkInfo.isCri && atkInfo.atkType == ATKTYPE.NORMAL:
		hurtPerP(atkInfo.cha,per(1.5),ATKTYPE.EFF)
		
