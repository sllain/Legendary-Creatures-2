extends Skill

func _data():
	name = "魔力之源"
	cd = 0
	tab = "法师"
	
func getDec():
	return tr("最终魔法攻击提高%d%%") % [per(0.30) * 100]

func _in():
	masCha.eqps.connect("onUp",self,"_itemUp")

func _itemUp(inx,oldItem,newItem):
	reset()

func setLv(val):
	.setLv(val)
	reset()

func _upS():
	._upS()
	reset()

func reset():
	self.matk = 0
	perAdd("matk",per(0.3))

#func setLv(val):
#	.setLv(val)
#	perAdd("matk",per(0.2))
