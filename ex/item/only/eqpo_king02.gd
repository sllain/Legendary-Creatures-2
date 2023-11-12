extends Eqp

func _data():
	name = "皇冠"
	isOnly = true
	var ds = {
		atk = 2,
		def = 2,
		maxHp = 1,
		mdef = 1,
	}
	attRatio(ds)
	lv = 5
	tab = "国王"

	dec = tr("当你获得增益状态时，你最近的2名友军也获得同样层数的该增益状态")

func _in():
	masCha.connect("onAddBuff",self,"r")
	
func r(buff):
	for i in masCha.getMinRanChas(2,2):
		masCha.castBuff(i,buff.id,buff.plusLv)
