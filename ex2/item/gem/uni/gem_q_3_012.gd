extends GemUn

func _data():
	name = "缓麻石"
	tab = "坦克 射手 法师"
	isUnique = true
	lock = 0

func getDec():
	return tr("被施加麻痹时，层数减半，对施加者施加%d层麻痹") % [per(6)]

func _in():
	masCha.connect("onAddBuff",self,"r")

func r(buff):
	if buff.id == "b_b_maBi":
		buff.lv *= 0.5
		masCha.castBuff(buff.castCha,"b_b_maBi",per(6))
