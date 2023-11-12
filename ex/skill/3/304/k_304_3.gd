extends Skill

func _data():
	name = "电能屏障"
	cd = 0
	tab = "机关人"
	
func getDec():
	return tr("对敌方施加麻痹时,每%d层麻痹获得%d%%最大生命值的护盾") %  [5,per(0.05) * 100]

func _in():
	masCha.connect("onCastBuff",self,"r")
	
func r(buff):
	if buff.masCha.team != masCha.team && buff.id == "b_b_maBi" :
		masCha.plusWard(masCha.maxHp * buff.plusLv * 0.2 * per(0.05))

