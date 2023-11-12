extends GemUn

func _data():
	name = "盗魂石"
	tab = "刺客 射手 法师"
	isUnique = true
	lock = 0
	
func getDec():
	return tr("击杀敌人时，获取目标等级*%d的魂") % [per(2)]
	
func _in():
	masCha.connect("onKill",self,"r")
	
func r(atkInfo):
	sys.player.items.addItem(data.newBase("m_xp").setNum(per(2)*atkInfo.cha.lv))
