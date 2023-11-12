extends Skill

func _data():
	name = "电流涌动"
	cd = 0
	tab = "雷法"
	
func getDec():
	return tr("每次对敌方施加麻痹时，%d%%概率自身获得%d层超然") % [25,per(5)]

func _in():
	masCha.connect("onCastBuff",self,"r")

func r(bf):
	if bf.id == "b_b_maBi":
		if sys.rndPer(0.25):
			masCha.castBuff(masCha,"b_a_chaoRan",per(5))
