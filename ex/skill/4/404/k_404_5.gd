extends Skill

func _data():
	name = "毫不留情"
	cd = 0
	tab = "暗杀者"

func getDec():
	return tr("暴击伤害提升%d%%，隐身期间普攻必定暴击") % [per(0.15)*100]

func _in():
	masCha.connect("onCastHurtStart",self,"r")
	
func r(atkInfo):
	if atkInfo.atkType != ATKTYPE.NORMAL: return
	if masCha.yingTime > 0:
		atkInfo.isCri = true

func setLv(val):
	.setLv(val)
	perAdd("criR",per(0.15))
