extends Eqp

func _data():
	name = "王者之戒"
	isOnly = true
	var ds = {
		matk = 3,
		cdSpd = 2,
		pen = 1,
	}
	attRatio(ds)
	lv = 5
	tab = "国王"

	dec = tr("当你获得超然时，也获得同样层数的威能")

func _in():
	masCha.connect("onAddBuff",self,"r")
	
func r(buff):
	if buff.id == "b_a_chaoRan" :
		masCha.castBuff(masCha,"b_a_weiNeng",buff.plusLv)
