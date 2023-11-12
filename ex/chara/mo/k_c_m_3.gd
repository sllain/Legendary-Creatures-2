extends Skill

func _data():
	name = "尖刺甲壳"
	cd = 0
	tab = "专属"
func getDec():
	return tr("物理防御提升%d%%,普通攻击%d%%的几率造成%d%%的物理防御的物理伤害和%d层麻痹") %  [30,40,per(80),per(8)]

func _in():
	masCha.connect("onHurt",self,"r")
	masCha.connect("onCastHurt",self,"r")
	masCha.eqps.connect("onUp",self,"_itemUp")
	
func r(atkInfo):
	if atkInfo.atkType == ATKTYPE.NORMAL && rndPer(0.4):
		if atkInfo.cha == null :return
		hurt(atkInfo.cha,per(0.8) * masCha.def)
		masCha.castBuff(atkInfo.cha,"b_b_maBi",per(8))

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
	perAdd("def",0.3)
	
#func setLv(val):
#	.setLv(val)
#	perAdd("def",0.4)
