extends GemUn

func _data():
	name = "抵毒石"
	tab = "坦克"
	isUnique = true

func getDec():
	return tr("免疫中毒")

func _in():
	masCha.connect("onAddBuff",self,"r")

func r(buff):
	if buff.id == "b_b_zhongDu":
		masCha.delAff(buff)
