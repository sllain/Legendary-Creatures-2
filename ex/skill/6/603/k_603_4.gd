extends Skill

var dmg = 0

func _data():
	name = "力量祝福"
	cd = 0
	tab = "圣骑士"
	
func getDec():
	return tr("对己方施加护盾时，同时附加%d层狂怒，威能，抵御") %  [per(8)]

func _in():
	masCha.connect("onCastPlusStart",self,"r")
	
func r(info):
	if info.type == "ward":
		masCha.castBuff(info.cha,"b_a_kuangNu",per(8))
		masCha.castBuff(info.cha,"b_a_weiNeng",per(8))
		masCha.castBuff(info.cha,"b_a_diYu",per(8))
