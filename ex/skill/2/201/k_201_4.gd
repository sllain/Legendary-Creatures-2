extends Skill

func _data():
	name = "破甲箭"
	cd = 0
	tab = "弓手"
	
func getDec():
	return tr("普通攻击%d%%的概率附加%d层破甲,暴击时必定附加") % [30,per(10)]

func _in():
	masCha.connect("onCastHurt",self,"r")
	
func r(info):
	if info.atkType == ATKTYPE.NORMAL:
		if info.isCri || sys.rndPer(0.3): 
			masCha.castBuff(info.cha,"b_b_poJia",per(10))
