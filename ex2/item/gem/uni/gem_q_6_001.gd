extends GemUn

func _data():
	name = "治疗赋能石"
	tab = "辅助"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("施加治疗时，目标获得%d层超然和抵御") % [per(5)]

func _in():
	masCha.connect("onCastPlus",self,"r")
	
func r(info):
	if info.type == "hp":
		masCha.castBuff(info.cha,"b_a_chaoRan",per(5))
		masCha.castBuff(info.cha,"b_a_diYu",per(5))
