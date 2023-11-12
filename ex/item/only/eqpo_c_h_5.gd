extends Eqp

func _data():
	name = "元素法杖"
	isOnly = true
	var ds = {
		matk = 3,
		cdSpd = 1,
		pen = 1,
	}
	attRatio(ds)
	lv = 5
	tab = "谜团"

	dec = tr("施加负面状态时，每%d层负面状态对目标造成%d%%的魔法伤害") % [5,50]

func _in():
	masCha.connect("onCastBuff",self,"r")
	
func r(buff:Buff):
	if buff.castCha != buff.masCha && buff.hasTab("deBuff"):
		hurtPerM(buff.masCha,0.5 * buff.plusLv * 0.2,ATKTYPE.EFF)
