extends GemUn

func _data():
	name = "灭焰石"
	tab = "坦克"
	isUnique = true
	lock = 0

func getDec():
	return tr("被施加烧灼时，层数减半，对施加者施加%d层烧灼") % [per(6)]

func _in():
	masCha.connect("onAddBuff",self,"r")

func r(buff):
	if buff.id == "b_b_shaoZhuo":
		buff.lv *= 0.5
		masCha.castBuff(buff.castCha,"b_b_shaoZhuo",per(6))
