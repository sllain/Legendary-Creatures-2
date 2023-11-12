extends Eqp

func _data():
	name = "远古巨钳"
	isOnly = true
	var ds = {
		def = 2,
		mdef = 2,
		maxHp = 1,
	}
	attRatio(ds)
	lv = 5
	tab = "谜团"
	
	dec = tr("每获得5层抵御，恢复%d%%最大生命值") % [3] 

func _in():
	masCha.connect("onAddBuff",self,"r")
	
func r(buff:Buff):
	if buff.id == "b_a_diYu" :
		masCha.plusHp(masCha.maxHp * 0.03 * buff.plusLv * 0.2)
