extends Skill

func _data():
	name = "精魂转移"
	cd = 0
	tab = "萨满"
	
func getDec():
	return tr("造成技能伤害时，使我方最虚弱单位恢复该伤害值%d%%的生命值") % [per(1.0) * 100]
	
func _in():
	masCha.connect("onCastHurt",self,"r")

func r(atkInfo):
	if atkInfo.atkType != ATKTYPE.SKILL :return
	var xcha = masCha.getWeakCha(2)
	if xcha != null	:
		plusHp(per(1.0) * atkInfo.finalVal,xcha)
