extends Skill

func _data():
	name = "扫堂腿"
	cd = 7
	tab = "专属"

func getDec():
	return tr("对周围1格造成%d%%的物理伤害，每命中一名敌人获得%d层 狂怒和抵御") %  [per(1.5) * 100,per(8)]

func _cast():
	masCha.playAnim("atk2")
	#mas.playSe("res://res/se/HeavySword4.wav")
	yield(ctime(0.4),"timeout")
	var eff = mas.scene.newEff("e_xuanFengZhan", mas.position,mas.imgCenterPos)
	yield(ctime(0.1),"timeout")
	for i in masCha.scene.getCellChas(mas.cell):
		if i.team != mas.team :
			hurtPer(i,per(1.5))
			masCha.castBuff(masCha,"b_a_kuangNu",per(8))
			masCha.castBuff(masCha,"b_a_diYu",per(8))
	
