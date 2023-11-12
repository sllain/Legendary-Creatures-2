extends Eqp

func _data():
	name = "星耀短杖"
	isOnly = true
	var ds = {
		matk = 3,
		cdSpd = 2,
	}
	attRatio(ds)
	lv = 5
	tab = "谜团"

	dec = tr("施放治疗或者护盾会为目标附加%d层随机增益") % [10]

func _in():
	masCha.connect("onCastPlus",self,"r")

const bbfs = ["b_a_kuangNu","b_a_weiNeng","b_a_jiSu","b_a_chaoRan","b_a_diYu"]
func r(info):
	masCha.castBuff(info.cha,rndListItem(bbfs),10)
