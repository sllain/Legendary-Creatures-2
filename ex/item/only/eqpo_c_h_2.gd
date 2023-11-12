extends Eqp

func _data():
	name = "冰之矢"
	isOnly = true
	var ds = {
		atk = 2,
		spd = 3,
		cri = 1,
	}
	attRatio(ds)
	lv = 5
	tab = "谜团"
	
	dec = tr("附加结霜时自身获得同样层数的急速，且普通攻击%d%%的几率附加%d层结霜") % [30,5]

func _in():
	masCha.connect("onCastBuff",self,"r")
	masCha.connect("onCastHurt",self,"r2")
	
func r(buff):
	if buff.id == "b_b_jieShuang" :
		masCha.castBuff(masCha,"b_a_jiSu",buff.plusLv)

func r2(info):
	if info.atkType == ATKTYPE.NORMAL && rndPer(0.3) :
		masCha.castBuff(info.cha,"b_b_jieShuang",5)
