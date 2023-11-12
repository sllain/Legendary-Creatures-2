extends Buff

func _data():
	name = "BOSS"
	isDie = false
	isLong = true
	isVis = true
	maxLv = 50
	tab = ""
	lock = -1

var p = 0.3

func getDec():
	return tr("增伤,减伤,施放的治疗和护盾， 最终值提高 %d%%") % [p * lv * 100]

func _in():
	masCha.connect("onHurtStart",self,"r")
	masCha.connect("onCastHurtStart",self,"r2")
	masCha.connect("onCastPlus",self,"r3")
	
func r(atkInfo):
		atkInfo.finalPer -= lv * p

func r2(atkInfo):
		atkInfo.finalPer += lv * p

func r3(info):
	info.finalPer += lv * p
