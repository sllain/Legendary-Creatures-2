extends Skill

var dmg = 0

func _data():
	name = "生命肉铠"
	cd = 0
	tab = "肉霸"
	
var pn = 120
	
func getDec():
	return tr("每%d点最大生命值获得%d点双防") %  [pn,per(5)]

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
	self.def = masCha.maxHp/pn*per(5)
	self.mdef = masCha.maxHp/pn*per(5)

