extends Skill

func _data():
	name = "元素抵抗"
	cd = 0
	tab = "重甲士"
	
func getDec():
	return tr("被施加负面状态时，回复%d%%最大生命值，获得%d层抵御，并且每层抵御会提高%d%%的回复值") % [4,per(5),3]
	
func _in():
	masCha.connect("onAddBuff",self,"r")

func r(buff):
	if buff.hasTab("deBuff"):
		var p = 1
		var b = masCha.castBuff(masCha,"b_a_diYu",per(5))
		if b == null:
			p += b.lv * 0.03
			plusHp(masCha.maxHp * 0.04 * p)

