extends Skill

var dmg = 0

func _data():
	name = "魔武修行"
	cd = 0
	tab = "魔武者"
	self.matk = 0.0
	
func getDec():
	return tr("每%d点物理攻击转化为%d点魔法攻击") %  [12,per(6)]

func _in():
	masCha.eqps.connect("onUp",self,"_itemUp")

func _itemUp(inx,oldItem,newItem):
	reset()

func _upS():
	._upS()
	reset()

func setLv(val):
	.setLv(val)
	reset()

func reset():
	if masCha == null:return
	self.matk = masCha.atk/12.0*per(6.0)

