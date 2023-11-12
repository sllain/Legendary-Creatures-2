extends Skill

func _data():
	name = "横扫"
	cd = 6
	tab = "专属"
	
func getDec():
	return tr("对周围1格造成%d%%物理伤害，附加%d层流血") % [per(1.5) * 100 , per(10)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_xuanFengZhan", mas.position,mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	for i in masCha.scene.getCellChas(mas.cell):
		if i.team != mas.team :
			hurtPer(i,per(1.5))
			masCha.castBuff(i,"b_b_liuXue",per(10))
