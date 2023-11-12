extends Skill

func _data():
	name = "铁壁盾墙"
	cd = 9
	tab = "盾卫"
	
func getDec():
	return tr("嘲讽周围1格敌人，每嘲讽一个敌人获得%d%%最大生命值的护盾") %  [per(15)]

func _cast():
	masCha.playAnim("buff")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_zhanHou",mas.position,mas.imgCenterPos)
	yield(eff,"onAnimTrig")
	for i in masCha.scene.getCellChas(mas.cell) :
		if i.team != mas.team :
			i.aiCha = masCha
			masCha.plusWard(masCha.maxHp * per(0.15))
