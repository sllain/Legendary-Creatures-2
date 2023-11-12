extends Skill

func _data():
	name = "板甲精通"
	cd = 0
	tab = "重甲士"
	
func getDec():
	return tr("最终的物理防御和魔法防御提高%d%%") % [per(0.40) * 100]

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
	self.def = 0
	perMul("def",per(0.4))
	perMul("mdef",per(0.4))
