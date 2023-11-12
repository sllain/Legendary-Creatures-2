extends Buff

func _data():
	name = "脆弱"
	isDie = false
	isLong = true
	maxLv = 99
	tab = ""
	lock = -1
	isVis = false
	
func getDec():
	return tr("增伤和减伤 减少 %d%%") % [1 * lv]

func _in():
	masCha.connect("onHurtStart",self,"r")
	masCha.connect("onCastHurtStart",self,"r2")
	
func r(atkInfo):
		atkInfo.finalPer += lv * 0.01

func r2(atkInfo):
		atkInfo.finalPer -= lv * 0.01
