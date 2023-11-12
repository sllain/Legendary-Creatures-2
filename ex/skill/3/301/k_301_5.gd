extends Skill

func _data():
	name = "盾术精通"
	cd = 0
	tab = "盾卫"
	
func getDec():
	return tr("提高%d%%获得的护盾值") % [per(0.30) * 100]

func _in():
	masCha.connect("onPlusStart",self,"r")
	
func r(info):
	if info.type == "ward":
		info.per += per(0.3)
