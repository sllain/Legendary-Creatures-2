extends GemUn

func _data():
	name = "止血石"
	tab = "坦克"
	isUnique = true

func getDec():
	return tr("免疫流血")

func _in():
	masCha.connect("onAddBuff",self,"r")

func r(buff):
	if buff.id == "b_b_liuXue":
		masCha.delAff(buff)
